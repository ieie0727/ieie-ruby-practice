class UsersController < ApplicationController
  before_action :login_forbit, only: [:login, :login_form]

  def login_form
  end

  def login
    @user =User.find_by(account: params[:account])
    if @user && @user.authenticate(params[:password])
      session[:user_id] =@user.id
      redirect_to "/students/index"
    end
  end

  def logout
    session[:user_id] =nil
    redirect_to "/users/login"
  end
  

end
