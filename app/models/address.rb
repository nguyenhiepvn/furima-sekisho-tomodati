class Address < ApplicationRecord
  belongs_to :order
 
  validates :postal_code, presence: { message: "can't be blank" }
  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
  validates :prefecture_id, presence: { message: "can't be blank" }
  validates :city, presence: { message: "can't be blank" }
  validates :address, presence: { message: "can't be blank" }
  validates :phone_number, presence: { message: "can't be blank" }
  validates :phone_number, length: { minimum: 10, message: "is too short" }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: "is invalid. Input only 10 or 11 digit numbers" }
 
end
