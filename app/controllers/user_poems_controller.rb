class UserPoemsController < ApplicationController
  before_action :authenticate_user!

  def index
    if ephemeral_poem?
      flash.now[:notice] = %Q[You've creted a new <a href="#{ephemeral_path}"> poem</a>.].html_safe
    end
    @user_poems_with_summary = {}
    current_user.user_poems.reverse.each do |up|
      @user_poem = up
      poem = Poem.find(up.poem_id)
      @user_poems_with_summary[poem] = create_summary_past_tense
    end
  end

  def create_summary_past_tense
    summary_hash = {}
    @summary = "On #{@user_poem.created_at.strftime("%B %d")}, "

    if @user_poem.match_type == "random"
      @summary << "with a random word."
    else

      @summary << "with the word \"#{@user_poem.keyword_text}\" "
      case @user_poem.keyword_source
      when "first_name"
        @summary << "because it's a great word ;)"
      when "birthday"
        @summary << "because it was your birthday :)"
      when "holiday"
        holiday_summary
      when "forecast"
        forecast_summary
      when "news"
        news_summary
      when "twitter"
        twitter_summary
      end
    end
    # binding.pry
    user_poem_hash = {}
    user_poem_hash[@user_poem.keyword_source] = @user_poem.keyword_source_id
    summary_hash[@summary] = user_poem_hash
    summary_hash
  end

  def holiday_summary
    @summary << "because #{@user_poem.keyword_text.titleize} was a holiday!"
  end

  def forecast_summary
    @summary << "which was in the weather forecast for #{@user_poem.keyword_source_id}."
  end

  def news_summary
    @summary << "which was in"
  end

  def twitter_summary
    @summary << "which was in"
  end


end


