class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :items
  has_many :orders
  has_many :comments

  # バリデーション
  validates :nickname,            presence: true
  validates :email,               presence: true
  validates :encrypted_pasword,   presence: true
  validates :first_name,          presence: true
  validates :last_name,           presence: true
  validates :first_name_kana,     presence: true
  validates :last_name_kana,      presence: true
  validates :birthday,            presence: true

end
