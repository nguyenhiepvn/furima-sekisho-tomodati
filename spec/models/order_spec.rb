# spec/models/order_spec.rb
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user).required(true) }
    it { is_expected.to belong_to(:item).required(true) }
    it { is_expected.to have_one(:address).dependent(:destroy) }
    it { is_expected.to accept_nested_attributes_for(:address) }
  end

  describe 'Validations' do
    it 'is valid with all attributes' do
      seller = FactoryBot.create(:user)
      buyer = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user: seller)
      order = FactoryBot.build(:order, user: buyer, item: item)
      expect(order).to be_valid
    end

    it 'is invalid without a user and item' do
      order = FactoryBot.build(:order, user: nil, item: nil)
      order.valid?
      expect(order.errors[:user]).to include("must exist")
      expect(order.errors[:item]).to include("must exist")
    end

    it 'is invalid if the buyer is the seller' do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item, user: user)
      order = FactoryBot.build(:order, user: user, item: item)
      order.valid?
      expect(order.errors[:user_id]).to include("User cannot buy your own item.")
    end
  end

  describe 'Custom Validation' do
    context 'buyer_is_not_seller method' do
      it 'is valid if the buyer is not the seller' do
        seller = FactoryBot.create(:user)
        buyer = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: seller)
        order = FactoryBot.build(:order, user: buyer, item: item)
        expect(order).to be_valid
      end

      it 'is invalid if the buyer is the seller' do
        user = FactoryBot.create(:user)
        item = FactoryBot.create(:item, user: user)
        order = FactoryBot.build(:order, user: user, item: item)
        order.valid?
        expect(order.errors[:user_id]).to include("User cannot buy your own item.")
      end
    end
  end
end
