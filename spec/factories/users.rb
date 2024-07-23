FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'sample1'}
    password_confirmation {password}
    birthday              {'2020.01.01'}
    last_name             {'さんぷる'}
    first_name            {'さんぷる'}
    last_name_kana        {'サンプル'}
    first_name_kana       {'サンプル'}
  end
end