#spec/factories/item.rb
FactoryBot.define do 
  factory :item do
    name { "見本商品" }
    description { "それは商品の説明のサンプルです" }
    price { 500 }
    category_id { 1 }
    condition_id { 1 }
    prefecture_id { 1 }
    postage_payer_id { 1 }
    preparation_day_id { 1 }
    association :user
    after(:build ) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec','files','sample_image.png')),filename: 'sample_image.png', content_type: 'image/jpeg')
    end
  end
end