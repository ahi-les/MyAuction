class Delivery < ApplicationRecord
  has_many :product_deliveries, dependent: :destroy
  has_many :products, through: :product_deliveries
end
