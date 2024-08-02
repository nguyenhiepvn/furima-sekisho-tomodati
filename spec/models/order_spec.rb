require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '内容に問題ない場合' do
    it "priceとtokenがあれば保存ができること" do
      order = FactoryBot.build(:order, price: 1000, token: 'tok_1234567890')
      expect(order).to be_valid
    end
  end

  describe '内容に問題がある場合' do
    it 'priceが空では保存できないこと' do
      order = FactoryBot.build(:order, price: nil)
      expect(order).not_to be_valid
    end

    it 'tokenが空では登録できないこと' do
      order = FactoryBot.build(:order, token: nil)
      expect(order).not_to be_valid
    end
  end
end