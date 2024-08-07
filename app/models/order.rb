class Order < ApplicationRecord
  attr_accessor :token
 
  belongs_to :user
  belongs_to :item
  has_one :address, dependent: :destroy
 
  accepts_nested_attributes_for :address
  validate :buyer_is_not_seller
 
  private
 
  def buyer_is_not_seller
    if item.user_id == user_id
      errors.add(:user_id, "You cannot buy your own item.")
    end
  end
 
 
end