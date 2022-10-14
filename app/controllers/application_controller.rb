class ApplicationController < ActionController::Base

  def login_check
    if session[:user_id]
      @user =User.find_by(id: session[:user_id])
    else
      redirect_to "/users/login"
    end
  end

  def login_forbit
    if session[:user_id]
      flash[:notice] ="ログイン済みです"
      redirect_to "/students/index"
    end
  end

  def top
    redirect_to "/students/index";
  end
  
end
