class UserPoemsController < ApplicationController
  before_action :authenticate_user!

  def index
    if ephemeral_poem?
      flash.now[:notice] = %Q[You've creted a new <a href="#{ephemeral_path}"> poem</a>.].html_safe
    end
    @user_poems = current_user.user_poems.reverse
    profile_incomplete?
  end

  def profile_incomplete?
    unless current_user.birthday.present? && current_user.location.present? && current_user.twitter_handle.present?
      @profile_incomplete = true
    end
  end
end


# poem title and poet
# user_poem keyword text, source, source_id and summary