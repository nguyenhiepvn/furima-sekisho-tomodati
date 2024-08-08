class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :token, :postal_code, :prefecture_id, :city, :address, :building, :phone_number
 
  # バリデーション
    validates :token, presence: { message: "を入力してください" }
    validates :postal_code, presence: { message: "を入力してください" }
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "無効です。次のように入力してください【例：123-4567】" }
    validates :prefecture_id, numericality: {  other_than: 0, message: "を入力してください" }
    validates :city, presence: { message: "を入力してください" }
    validates :address, presence: { message: "を入力してください" }
    validates :phone_number, presence: { message: "を入力してください" }
    validates :phone_number, length: { minimum: 10, maximum: 11, message: "短すぎます" }
    validates :phone_number, format: { with: /\A\d+\z/, message: "無効です。数字のみ入力してください" }
    validates :item_id, presence: true
    validates :user_id, presence: true

 
  # データを保存する処理
  def save
  # binding.pry
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(order_id: order.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address, building: building, phone_number: phone_number)
  end
end