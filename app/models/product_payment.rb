class ProductPayment < ApplicationRecord
  belongs_to :product
  belongs_to :payment
end
