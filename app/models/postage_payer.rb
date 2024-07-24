# app/models/delivery_burden.rb
class PostagePayer < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '着払い(購入者負担)' },
    { id: 2, name: '送料込み(出品者負担)' }
  ]
end
