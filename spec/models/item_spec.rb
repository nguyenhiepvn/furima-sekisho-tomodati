require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'バリデーション' do 
      before do 
        @item = FactoryBot.build(:item)
      end
    it '有効な属性であれば有効である' do
      expect(@item).to be_valid
    end
    it '画像がなければ無効である' do
      @item.image = nil
      expect(@item).not_to be_valid
      expect(@item.errors[:image]).to include("can't be blank")
    end
    
  end
end
