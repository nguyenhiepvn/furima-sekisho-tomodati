# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path
    else
      render :new
    end
  end
  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birthday)
    end

end
