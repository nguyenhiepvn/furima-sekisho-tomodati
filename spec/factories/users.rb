FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.email}
    password              {'sample1'}
    password_confirmation {'sample1'}
    birthday              {'2020.01.01'}
    last_name             {'さんぷる'}
    first_name            {'さんぷる'}
    last_name_kana        {'サンプル'}
    first_name_kana       {'サンプル'}
  end
end