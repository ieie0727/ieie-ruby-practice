class User < ApplicationRecord
  has_secure_password
  validates :account, uniqueness: true
end
