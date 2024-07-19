require 'rails_helper'

RSpec.describe User, type: :model do

  describe '新規登録/ユーザー情報' do
    
    it 'ニックネームが空では登録できない' do

    end

    it 'メールアドレスが空では登録できない' do

    end

    it 'メールアドレスが一意であること' do

    end

    it 'メールアドレスは、@を含む必要があること' do

    end

    it 'パスワードが空では登録できない' do

    end

    it 'パスワードは、6文字以上での入力が必須であること' do

    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
     
    end

    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
   
    end
  end

  describe '新規登録/本人情報確認' do

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
    
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do

    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do

    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do

    end

    it '生年月日が必須であること' do

    end
  end
  
end
