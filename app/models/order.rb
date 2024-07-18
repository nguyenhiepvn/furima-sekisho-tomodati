class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :address

  validates :title, presence: true
end
