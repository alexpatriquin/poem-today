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

  def ephemeral_poem?
    session[:ephemeral_poem] && session[:ephemeral_poem].count > 4 #minimum is 4
  end

  def image_url(keyword)
    FlickRaw.api_key = ENV["FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_API_SECRET"]
    begin
      binding.pry
      flickr_photo = flickr.photos.search("text"=>"#{keyword}", "sort"=> "relevance").first
      @poem_image_url = "http://farm#{flickr_photo.farm}.staticflickr.com/#{flickr_photo.server}/#{flickr_photo.id}_#{flickr_photo.secret}.jpg"
    rescue
      @poem_image_url = ""
    end
  end

end
