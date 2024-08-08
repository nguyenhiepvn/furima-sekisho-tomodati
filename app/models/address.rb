class Address < ApplicationRecord
  belongs_to :order
 
  validates :postal_code, presence: true
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/}
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :phone_number, length: {minimum: 10, maximum: 11 }
  validates :phone_number, format: { with: /\A\d{10,11}\z/}
 
end
