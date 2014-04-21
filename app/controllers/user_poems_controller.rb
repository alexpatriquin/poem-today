class UserPoemsController < ApplicationController
  before_action :authenticate_user!

  def index
    if session[:ephemeral_poem].count >= 3
      flash.now[:notice] = %Q[You've creted a new <a href="#{ephemeral_path}">ephemeral poem</a>.].html_safe
    end

    @user_poems_with_content = {}
    current_user.user_poems.each do |user_poem| 
      @user_poems_with_content[user_poem] = Poem.find(user_poem.poem_id)
    end
  end 

end