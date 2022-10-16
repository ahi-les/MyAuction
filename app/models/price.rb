class Price < ApplicationRecord
  belongs_to :product
  validates :price, numericality: { in: 1..10000000 }, presence: true, length: {minimum: 1}
end
