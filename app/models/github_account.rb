class GithubAccount < ActiveRecord::Base
  validates :uid, presence: true
  validates :username, presence: true
  validates :display_name, presence: true
  validates :email, presence: true
end
