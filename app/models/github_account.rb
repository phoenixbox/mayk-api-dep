class GithubAccount < ActiveRecord::Base
  belongs_to :authentication, dependent: :destroy
  validates :uid, presence: true
  validates :username, presence: true
  validates :display_name, presence: true
  validates :email, presence: true
  validates :raw, presence: true
  validates :authentication_id, presence: true
end
