class SessionsController < ApplicationController

  def new
    @user = User.new(flash[:user])
  end

  def create
    user = User.find_by(mail: signin_params[:mail])
    if user && user.authenticate(signin_params[:password])
      sign_in2(user)
      redirect_to issues_path, flash: { success: "サインインしました" }
    else
      redirect_to :back, flash: { user: user, login_error: "ログイン情報が正しくありません"}
      # redirect_to :back, flash: { user: user, alert: ["ログイン情報が正しくありません"]}
    end
  end

  def destroy
    sign_out2()
    redirect_to home_path
  end

  private
  def signin_params
    params.require(:user).permit(:mail, :password)
  end

end
