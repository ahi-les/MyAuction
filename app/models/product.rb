class Product < ApplicationRecord
  belongs_to :category
  belongs_to :condition
  belongs_to :gender, required: false
  belongs_to :status
  belongs_to :user

  has_many_attached :images
  has_many :prices, dependent: :destroy

  has_many :product_deliveries, dependent: :destroy
  has_many :deliveries, through: :product_deliveries

  has_many :product_payments, dependent: :destroy
  has_many :payments, through: :product_payments

  validates :title, presence: true, length: {minimum: 2}
  validates :description, presence: true, length: {minimum: 3}
  validates :message, presence: true, length: {minimum: 5}
  
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :sity, presence: true, length: {minimum: 2}
  validates :starting_price, numericality: { in: 1..10000000 }, presence: true, length: {minimum: 1}
  validates :buy_now, numericality: { in: 1..10000000 }, presence: true, length: {minimum: 1}

  validate :end_date_is_after_start_date
  validate :start_date_is_after_current_time

  scope :all_by_deliveries, lambda { |deliveries|
    products = includes(:user)
    products = if deliveries
                  products.joins(:deliveries).where(deliveries: deliveries).preload(:deliveries)
                else
                  products.includes(:product_deliveries, :deliveries)
                end

    products.order(created_at: :desc)
  }

  scope :all_by_payments, lambda { |payments|
    products = includes(:user)
    products = if deliveries
                  products.joins(:payments).where(payments: deliveries).preload(:payments)
                else
                  products.includes(:product_payments, :payments)
                end

    products.order(created_at: :desc)
  }

  private

  def end_date_is_after_start_date
    if end_date < start_date
      errors.add(:end_date, 'cannot be before the start date')
    end
  end

  def start_date_is_after_current_time
    if start_date < (DateTime.now)
      errors.add(:start_date, 'cannot be before the current time')
    end
  end
end