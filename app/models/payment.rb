class Payment < ApplicationRecord
  has_many :product_payments, dependent: :destroy
  has_many :products, through: :product_payments
end
