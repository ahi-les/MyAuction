class Price < ApplicationRecord
  belongs_to :product
  validates :price, numericality: { in: 1..10000000 }, presence: true, length: {minimum: 1}
  validates :product_id, presence: true, length: {minimum: 1}

  validate :price_more_starting_price
  validate :price_last_more

  after_commit -> { broadcast_update_to "price", partial: "prices/pricess", locals: { price: price_last }, target: "price" }

  

  def price_more_starting_price
    starting_price = Product.where(id: product_id)
    if price <= starting_price[0].starting_price
        errors.add(:price, 'cannot be before the starting price')
    end  
  end

  def price_last_more
    if price_last.present?
      if price <= price_last
          errors.add(:price, 'cannot be before the price last')
      end
    end    
  end

  def price_last
    Price.where(product_id: product_id).last&.price
  end
end    