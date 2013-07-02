class UsersController < ApplicationController

  def new
    if request.post?
      @user = User.new(params[:user])
      if @user.save
        redirect_to users_created_path
      end
    else
      @user = User.new
    end
  end

  def login
  end

  def validate_login
    user_db = User.where(:email => params[:email]).first

    isValid = PasswordEncryptor.valid?(user_db.password_hash, params[:password])

    if isValid
      redirect_to root_path
    else
      redirect_to users_login_path
    end
  end
end
