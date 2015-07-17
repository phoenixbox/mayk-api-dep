class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable

  after_create :update_access_token!

  validates :username, presence: true
  validates :email, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    end
  end

  private

  def update_access_token!
    uuid = SecureRandom.base64
    self.uuid = uuid
    self.access_token = "#{uuid}:#{Devise.friendly_token}"
    save
  end

end
