class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :login_error
  helper_method :signed_in?
  helper_method :product_issues_path_switch
  before_action :current_user2, :global_search
  

  def sign_in1(user)
    session[:user_id] = user.id
  end

  def sign_out1
    session.delete(:user_id)
  end

  def sign_in2(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
  end

  def sign_out2
    @current_user = nil
    cookies.delete(:user_remember_token)
  end

  def current_user1
    if session[:user_id].blank?
      @current_user = User.new
    else
      @current_user ||= User.find(session[:user_id])
    end
  end

  def current_user2
    remember_token = User.encrypt(cookies[:user_remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
    # @current_user ||= User.new
  end

  def signed_in?
    @current_user.present?
  end

  def global_search
    @filter = {}
    @filter[:findword] = nil
  end

  def product_issues_path_switch(product)
    if product.present?
      product_issues_path(product)
    else
      issues_path
    end
  end
end
