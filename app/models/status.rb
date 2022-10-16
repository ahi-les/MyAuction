class Status < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, presence: true, length: {minimum: 2}
end
