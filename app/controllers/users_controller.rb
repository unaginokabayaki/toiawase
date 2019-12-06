class UsersController < ApplicationController
  def new
    @user = User.new(flash[:user])
  end

  def create
    user = User.new(user_params)
    if user.save
      sign_in2(user)
      redirect_to "#", flash: { success: "アカウントが作成されました" }
    else
      redirect_to :back, flash: { user: user, alert: user.errors.full_messages }
    end
  end
  
  def show
    # @user = User.find()
  end

  def edit
    @user = User.find(@current_user.id)
  end

  def update
    user = User.find(@current_user.id)
    # user = User.new(user_params)
    if user.update(user_params)
      redirect_to edit_users_path, success: '保存しました'
    else
      redirect_to :back, flash: { user: user, alert: user.errors.full_messages }
    end
  end

  def destroy
    @user = User.find(@current_user.id)
    @user.destroy
    redirect_to root, success: "アカウントを削除しました"
  end

  private
  def user_params
    params.require(:user).permit(:name, :mail, :password, :password_confirmation, :profile, :image)
  end
end
