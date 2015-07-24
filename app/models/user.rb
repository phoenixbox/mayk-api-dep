class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable

  after_create :update_access_token!

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true

  has_many :authentications

  def self.from_omniauth(params)
    auth = Authentication.where(uid: params['account']['id'], token: params['token']).take

    # If that Authentication doesnt exist for the user then craete it
    if !auth
      password = Devise.friendly_token[0,20]
      user = User.create!({
        :email => params['account']['email'],
        :username => params['account']['username'],
        :uuid => "",
        :password => password,
        :password_confirmation => password
      })

      user.createAuthentication(params)
      user
    else
      # That auth exists so just return the user
      auth.user
    end
  end

  def createAuthentication(params)
    auth = self.authentications.create({
      :uid => params['account']['id'],
      :provider => params['provider'],
      :token => params['token']
    })

    createGithubAccount(auth, params)
  end

  def createGithubAccount(auth, params)
    GithubAccount.create({
      :uid => params['account']['id'],
      :username => params['account']['username'],
      :display_name => params['account']['displayName'],
      :email => params['account']['email'],
      :raw => params['account']['raw'],
      :token => auth.token,
      :authentication_id => auth.id
    })
  end

  def refresh_access_token
    self.access_token = "#{self.uuid}:#{Devise.friendly_token}"
  end

  private

  def update_access_token!
    # Do I have access to the original params? or do they need to be passed in?
    uuid = SecureRandom.base64
    self.uuid = uuid
    self.access_token = generate_access_token(uuid)
    save
  end

  def generate_access_token(uuid)
    loop do
      token = "#{uuid}:#{Devise.friendly_token}"
      break token unless User.where(access_token: token).first
    end
  end
end
