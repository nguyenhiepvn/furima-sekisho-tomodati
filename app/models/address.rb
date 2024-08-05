class Address < ApplicationRecord
  belongs_to :order

  validates :postal_code,        presence: true, format: { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
  validates :prefecture_id ,     presence: true, numericality: { only_integer: true }
  validates :city,               presence: true
  validates :address,            presence: true
  validates :phone_number,       presence: true, format: { with: /\A\d{10,11}\z/, message: 'is invalid. Input only 10 or 11 digit numbers' }
  validates :order_id,           presence: true, length: { maximum: 11 }, format: { with: /\A\d+\z/, message: 'is invalid. Input only number' }
end
