class Authentication < ActiveRecord::Base
  validates :uid, presence: true
  validates :provider, presence: true
  validates :token, presence: true
end
