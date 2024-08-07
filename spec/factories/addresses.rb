FactoryBot.define do
  factory :address do
    postal_code { "000-0000" }
    prefecture_id { 1 }
    city { "市町村" }
    address { "番地0-0-0" }
    building { "建物名" }
    phone_number { "00000000000" }
    # order { nil }
  end
end