require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規登録/ユーザー情報' do

    context '新規登録できるとき' do
      
      it 'nicknameとemail、passwordとpassword_confirmationが存在すればできる' do
        expect(@user).to be_valid
      end
    
    end
    
    context '新規登録できないとき' do

      it 'ニックネームが空では登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネーム を入力してください"
      end

      it 'メールアドレスが空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレス を入力してください"
      end

      it 'メールアドレスが一意であること' do
        FactoryBot.create(:user, email: 'unique@example.com')
        user = FactoryBot.build(:user, email: 'unique@example.com')
        user.valid?
        expect(user.errors.full_messages).to include "メールアドレス はすでに存在します"
      end

      it 'メールアドレスは、@を含む必要があること' do
        @user.email = "testexample.com"
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレス は無効です"
      end

      it 'パスワードが空では登録できない' do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード を入力してください"
      end

      it 'パスワードは、6文字以上での入力が必須であること' do
        @user.password = "sam12"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード は6文字以上で入力してください"
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = "sample"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード は無効です"
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = "123456"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード は無効です"
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = "あいうえおか"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード は無効です"
      end

      it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
        @user.password = "sample1"
        @user.password_confirmation = "sample2"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード確認 とパスワード致しません"
      end

      it 'お名前(全角)は、姓（全角）が空だと登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("姓 を入力してください")
      end

      it 'お名前(全角)は、名（全角）が空だと登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("名 を入力してください")
      end

      it 'お名前カナ(全角)は、姓（漢字・ひらがな・カタカナ）が空だと登録できない' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include('姓カナ は無効です')
      end

      it 'お名前カナ(全角)は、名（漢字・ひらがな・カタカナ）が空だと登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include('名カナ は無効です')
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.last_name = "sample"
        @user.valid?
        expect(@user.errors.full_messages).to include("姓 は無効です")
      end

      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.first_name = "sample"
        @user.valid?
        expect(@user.errors.full_messages).to include("名 は無効です")
      end

      it '姓（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.last_name_kana = "サンプる"
        @user.valid?
        expect(@user.errors.full_messages).to include("姓カナ は無効です")
      end

      it '名（カナ）にカタカナ以外の文字（平仮名・漢字・英数字・記号）が含まれていると登録できない' do
        @user.first_name_kana = "サンプる"
        @user.valid?
        expect(@user.errors.full_messages).to include("名カナ は無効です")
      end

      it '生年月日が必須であること' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日 を入力してください")
      end
    end
  end
end
