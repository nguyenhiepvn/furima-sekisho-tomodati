require 'rails_helper'

RSpec.describe User, type: :model do

  describe '新規登録/ユーザー情報' do

    context '新規登録できるとき' do
      
      it 'nicknameとemail、passwordとpassword_confirmationが存在すればできる' do
        user = FactoryBot.build(:user)
        user.valid?
        expect(user.errors.full_messages)
      end
    
    end
    
    context '新規登録できないとき' do

      it 'ニックネームが空では登録できない' do
        user = FactoryBot.build(:user)
        user.nickname = ""
        user.valid?
        expect(user.errors.full_messages).to include "Nickname can't be blank"
      end

      it 'メールアドレスが空では登録できない' do
        user = FactoryBot.build(:user)
        user.email = ""
        user.valid?
        expect(user.errors.full_messages).to include "Email can't be blank"
      end

      it 'メールアドレスが一意であること' do
        FactoryBot.create(:user)
        user = FactoryBot.build(:user)
        user.valid?
        expect(user.errors.full_messages).to include "Email has already been taken"
      end

      it 'メールアドレスは、@を含む必要があること' do
        user = FactoryBot.build(:user)
        user.email = "testexample.com"
        user.valid?
        expect(user.errors.full_messages).to include "Email is invalid"
      end

      it 'パスワードが空では登録できない' do
        user = FactoryBot.build(:user)
        user.password = ""
        user.valid?
        expect(user.errors.full_messages).to include "Password can't be blank"
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        user = FactoryBot.build(:user)
        user.password = "sam12"
        user.valid?
        expect(user.errors.full_messages).to include "Password is too short (minimum is 6 characters)"
      end

      it '英字のみのパスワードでは登録できない' do
        user = FactoryBot.build(:user)
        user.password = "sample"
        user.valid?
        expect(user.errors.full_messages).to include "Password is invalid"
      end

      it '数字のみのパスワードでは登録できない' do
        user = FactoryBot.build(:user)
        user.password = "123456"
        user.valid?
        expect(user.errors.full_messages).to include "Password is invalid"
      end

      it '全角文字を含むパスワードでは登録できない' do
        user = FactoryBot.build(:user)
        user.password = "あいうえおか"
        user.valid?
        expect(user.errors.full_messages).to include "Password is invalid"
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        user = FactoryBot.build(:user)
        user.password = "sample1"
        user.password_confirmation = "sample2"
        user.valid?
        expect(user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'お名前(全角)は、姓（全角）が空だと登録できない' do
        user = FactoryBot.build(:user)
        user.last_name = ""
        user.valid?
        expect(user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'お名前(全角)は、名（全角）が空だと登録できない' do
        user = FactoryBot.build(:user)
        user.first_name = ""
        user.valid?
        expect(user.errors.full_messages).to include("First name can't be blank")
      end

      it 'お名前カナ(全角)は、姓（漢字・ひらがな・カタカナ）が空だと登録できない' do
        user = FactoryBot.build(:user)
        user.last_name_kana = ""
        user.valid?
        expect(user.errors.full_messages).to include('Last name kana is invalid')
      end

      it 'お名前カナ(全角)は、名（漢字・ひらがな・カタカナ）が空だと登録できない' do
        user = FactoryBot.build(:user)
        user.first_name_kana = ""
        user.valid?
        expect(user.errors.full_messages).to include('First name kana is invalid')
      end

      it '生年月日が必須であること' do
        user = FactoryBot.build(:user)
        user.birthday = ""
        user.valid?
        expect(user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
