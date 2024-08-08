FactoryBot.define do
  factory :order do
    price { 1000 } # priceのデフォルト値
    token { 'tok_1234567890' } # tokenのデフォルト値
    association :user
    association :item
  end
end
