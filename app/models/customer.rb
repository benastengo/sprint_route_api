class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  geocoded_by :address
  after_validation :geocode
end
