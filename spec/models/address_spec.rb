# spec/models/address_spec.rb
require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'バリデーション' do
    it '全ての属性が有効である場合、アドレスは有効である' do
      address = FactoryBot.build(:address)
      expect(address).to be_valid
    end

    it '郵便番号がない場合は無効である' do
      address = FactoryBot.build(:address, postal_code: nil)
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end

    it '郵便番号の形式が正しくない場合は無効である' do
      address = FactoryBot.build(:address, postal_code: '1234-567')
      address.valid?
      expect(address.errors[:postal_code]).to include("is invalid. Enter it as follows (e.g. 123-4567)")
    end

    it '都道府県IDがない場合は無効である' do
      address = FactoryBot.build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("can't be blank")
    end

    it '市町村がない場合は無効である' do
      address = FactoryBot.build(:address, city: nil)
      address.valid?
      expect(address.errors[:city]).to include("can't be blank")
    end

    it '住所がない場合は無効である' do
      address = FactoryBot.build(:address, address: nil)
      address.valid?
      expect(address.errors[:address]).to include("can't be blank")
    end

    it '電話番号がない場合は無効である' do
      address = FactoryBot.build(:address, phone_number: nil)
      address.valid?
      expect(address.errors[:phone_number]).to include("can't be blank")
    end

    it '電話番号が短すぎる場合は無効である' do
      address = FactoryBot.build(:address, phone_number: '090123456')
      address.valid?
      expect(address.errors[:phone_number]).to include("is invalid. Input only 10 or 11 digit numbers")
    end

    it '電話番号が長すぎる場合は無効である' do
      address = FactoryBot.build(:address, phone_number: '090123456789')
      address.valid?
      expect(address.errors[:phone_number]).to include("is invalid. Input only 10 or 11 digit numbers")
    end

    it '電話番号に数字以外の文字が含まれている場合は無効である' do
      address = FactoryBot.build(:address, phone_number: '090-1234-5678')
      address.valid?
      expect(address.errors[:phone_number]).to include("is invalid. Input only 10 or 11 digit numbers")
    end
  end
end
