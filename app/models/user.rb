class User < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :validatable

  after_create :update_access_token!

  validates :username, presence: true
  validates :email, presence: true

  private

  def update_access_token!
    uuid = SecureRandom.base64
    self.uuid = uuid
    self.access_token = "#{uuid}:#{Devise.friendly_token}"
    save
  end

end
