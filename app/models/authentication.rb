class Authentication < ActiveRecord::Base
  validates :uid, presence: true
  validates :provider, presence: true
  validates :token, presence: true
  validates :user_id, presence: true

  belongs_to :user, dependent: :destroy
end
