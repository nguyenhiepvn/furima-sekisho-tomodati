FactoryBot.define do
  factory :order do
    association :user
    association :item

    after(:build) do |order|
      order.address ||= FactoryBot.build(:address, order: order)
    end
  end
end