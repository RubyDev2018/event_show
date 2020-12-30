class SessionsController < ApplicationController
  skip_before_action :authenticate, only: :create

  def create
    user = User.find_or_create_from_auth_hash!(request.env["omniauth.auth"]) # 1
    session[:user_id] = user.id #2
    redirect_to root_path, notice: "ログインしました。" #3
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました。"
    
  end
end
