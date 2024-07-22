require 'rails_helper'

RSpec.describe User, type: :model do

  describe '新規登録/ユーザー情報' do
    
    it 'ニックネームが空では登録できない' do
      user = User.new(nickname: '', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'メールアドレスが空では登録できない' do
      user = User.new(nickname: 'test', email: '', password: 'password123', password_confirmation: 'password123', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'メールアドレスが一意であること' do
      User.create(nickname: 'test1', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user = User.new(nickname: 'test2', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Email has already been taken')
    end

    it 'メールアドレスは、@を含む必要があること' do
      user = User.new(nickname: 'test', email: 'testexample.com', password: 'password123', password_confirmation: 'password123', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Email is invalid')
    end

    it 'パスワードが空では登録できない' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: '', password_confirmation: '', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'パスワードは、6文字以上での入力が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: '12345', password_confirmation: '12345', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
    end

    it 'パスワードは、半角英数字混合での入力が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password', password_confirmation: 'password', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('Password is invalid')
    end

    it 'パスワードとパスワード（確認）は、値の一致が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password123', password_confirmation: 'password321', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe '新規登録/本人情報確認' do

    it 'お名前(全角)は、名字と名前がそれぞれ必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', first_name: '', last_name: '', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("First name can't be blank", "Last name can't be blank")
    end

    it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）での入力が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', first_name: 'Taro', last_name: 'Yamada', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('First name is invalid', 'Last name is invalid')
    end

    it 'お名前カナ(全角)は、名字と名前がそれぞれ必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', first_name: '太郎', last_name: '山田', first_name_kana: '', last_name_kana: '', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include("First name kana can't be blank", "Last name kana can't be blank")
    end

    it 'お名前カナ(全角)は、全角（カタカナ）での入力が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', first_name: '太郎', last_name: '山田', first_name_kana: 'たろう', last_name_kana: 'やまだ', birthday: '2000-01-01')
      user.valid?
      expect(user.errors.full_messages).to include('First name kana is invalid', 'Last name kana is invalid')
    end

    it '生年月日が必須であること' do
      user = User.new(nickname: 'test', email: 'test@example.com', password: 'password123', password_confirmation: 'password123', first_name: '太郎', last_name: '山田', first_name_kana: 'タロウ', last_name_kana: 'ヤマダ', birthday: '')
      user.valid?
      expect(user.errors.full_messages).to include("Birthday can't be blank")
    end
  end
  
end
