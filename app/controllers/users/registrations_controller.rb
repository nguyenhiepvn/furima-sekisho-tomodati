# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user) # ユーザーをサインインさせます
      redirect_to after_sign_up_path_for(@user) # サインアップ後のリダイレクト先を指定
    else
      render :new
    end
  end

  protected

  # サインアップ後のリダイレクト先を指定
  def after_sign_up_path_for(resource)
    root_path # 遷移先のパスを指定
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
  end

end
