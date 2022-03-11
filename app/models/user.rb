class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :tractor_number, presence: true, uniqueness: true
  validates :trailer_number, presence: true, uniqueness: true
  has_many :orders
end
