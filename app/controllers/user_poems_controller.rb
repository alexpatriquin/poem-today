class UserPoemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @user_poems_with_content = {}
    current_user.user_poems.each do |user_poem| 
      @user_poems_with_content[user_poem] = Poem.find(user_poem.poem_id)
    end
  end 
end
