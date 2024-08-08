class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :token, :postal_code, :prefecture_id, :city, :address, :building, :phone_number
 
  # バリデーション
    validates :token, presence: { message: "can't be blank" }
    validates :postal_code, presence: { message: "can't be blank" }
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)" }
    validates :prefecture_id, numericality: {  other_than: 0, message: "can't be blank" }
    validates :city, presence: { message: "can't be blank" }
    validates :address, presence: { message: "can't be blank" }
    validates :phone_number, presence: { message: "can't be blank" }
    validates :phone_number, length: { minimum: 10, maximum: 11, message: "is too short" }
    validates :phone_number, format: { with: /\A\d+\z/, message: "is invalid. Input only number" }
 
  # データを保存する処理
  def save
  # binding.pry
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number)
  end
end