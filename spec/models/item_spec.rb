# spec/models/item_spec.rb
require 'rails_helper'

RSpec.describe Item, type: :model do

  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do

    context '出品できるとき' do
      it '必要な情報が全て存在すれば出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できないとき' do
      it '画像が空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品画像 を入力してください")
      end

      it '商品名が空では出品できない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名 を入力してください")
      end

      it '商品の説明が空では出品できない' do
        @item.description = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明 を入力してください")
      end

      it '価格が空では出品できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 を入力してください")
      end

      it '価格が300未満では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は300円から9,999,999円の範囲です")
      end

      it '価格が10000000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 は300円から9,999,999円の範囲です")
      end

      it '価格が半角数字でなければ出品できない' do
        @item.price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格 が数値ではありません")
      end

      it 'カテゴリーの選択が必須であること' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリー を選んでください")
      end

      it '商品の状態の選択が必須であること' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態 を選んでください")
      end

      it '配送料の負担の選択が必須であること' do
        @item.postage_payer_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担 を選んでください")
      end

      it '発送元の地域の選択が必須であること' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域 を選んでください")
      end

      it '発送までの日数の選択が必須であること' do
        @item.preparation_day_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数 を選んでください")
      end

      it 'userが紐付いていなければ出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("User を入力してください")
      end
    end
  end
end
