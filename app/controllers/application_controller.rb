class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :remember_me, :location, :birthday, :first_name, :twitter_handle) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, :location, :birthday, :first_name, :twitter_handle) }
  end

  def ephemeral_session?
    !session[:ephemeral_poem].nil? && !session[:ephemeral_poem].empty?
  end

  def ephemeral_poem?
    session[:ephemeral_poem] && session[:ephemeral_poem].count > 5 #minimum is 4
  end

end
