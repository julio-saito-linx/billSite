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

  def created
  end

  def login
  end
end
