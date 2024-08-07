require 'rails_helper'

RSpec.describe Address, type: :model do
  
  before do
    @address = FactoryBot.build(:address)
  end

  describe '配送先情報' do

    context '購入できるとき' do
    
      it '正しい情報を入力したとき' do
        expect(@address).to be_valid
      end

      it '建物名が空白の時' do
        @address.building = nil
        expect(@address).to be_valid
      end

    end

    context '購入できないとき' do

      it '郵便番号が空白のとき' do
        @address.postal_code = nil
        expect(@address).not_to be_valid
      end

      it '郵便番号が半角文字列でないとき' do
        @address.postal_code = '１２３４５６７'
        expect(@address).not_to be_valid
      end

      it '郵便番号にハイフンがないとき' do
        @address.postal_code = '1234567'
        expect(@address).not_to be_valid
      end

      it '郵便番号のハイフンの位置が異なるとき' do
        @address.postal_code = '12-34567'
        expect(@address).not_to be_valid
      end

      it '都道府県が空白のとき' do
        @address.prefecture_id = nil
        expect(@address).not_to be_valid
      end

      it '都道府県が数値でないとき' do
        @address.prefecture_id = 'abc'
        expect(@address).not_to be_valid
      end

      it '市区町村が空白のとき' do
        @address.city = nil
        expect(@address).not_to be_valid
      end

      it '番地が空白のとき' do
        @address.address = nil
        expect(@address).not_to be_valid
      end

      it '電話番号が空白のとき' do
        @address.phone_number = nil
        expect(@address).not_to be_valid
      end

      it '電話番号にハイフンが含まれるとき' do
        @address.phone_number = '090-0000-0000'
        expect(@address).not_to be_valid
      end

      it '電話番号が10桁未満のとき' do
        @address.phone_number = '09000000'
        expect(@address).not_to be_valid
      end

      it '電話番号が11桁より多いとき' do
        @address.phone_number = '000000000000'
        expect(@address).not_to be_valid
      end
    end
  end
end
