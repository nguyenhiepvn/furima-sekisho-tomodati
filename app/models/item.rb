# app/models/item.rb
class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :postage_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :preparation_day

  has_one_attached :image

  validates :image, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true,  numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 300, 
    less_than_or_equal_to: 9_999_999 
  }
  validates :category_id,  numericality: { other_than: 0 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :postage_payer_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :prefecture_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :preparation_day_id, numericality: { other_than: 0 , message: "can't be blank"}
  validates :user, presence: true

  belongs_to :user
  has_many :orders

  def sold?
    # 例えば、アイテムが注文された場合は売却済みとする
    Order.where(item_id: self.id).exists?
  end


  def self.ransackable_attributes(auth_object = nil)
    %w[category_id condition_id created_at description id name postage_payer_id prefecture_id preparation_day_id price updated_at user_id]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[category condition image_attachment image_blob postage_payer prefecture preparation_day user]
  end

end
