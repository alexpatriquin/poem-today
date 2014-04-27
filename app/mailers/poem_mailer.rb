class PoemMailer < ActionMailer::Base
  default from: "PoemToday@poemtoday.com"

  def daily_email(user)
    @user = user
    @user_poem = PoemMatcher.new(user).match_poem
    @poem = Poem.find(@user_poem.poem_id)
    @poem_url = "http://poemtoday.com#{poem_path(@poem)}"
    create_summary_present_tense

    mail(to: @user.email, subject: "#{@poem.title}")

    if @user.twitter_handle.present?
      TWITTER_CLIENT.update("Good morning @#{@user.twitter_handle}, here is your poem for today. #{@poem_url}?keyword=#{@user_poem.keyword_text}")
    end
  end

  def create_summary_present_tense
    summary_hash = {}
    @summary = "You were matched to this poem today "

    if @user_poem.match_type == "random"
      @summary << "with a random word."
    else

      @summary << "with the word \"#{@user_poem.keyword_text}\" "
      case @user_poem.keyword_source
      when "first_name"
        @summary << "because that's your name ;)"
      when "birthday"
        @summary << "because today's your birthday. Happy birthday!"
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
    user_poem_hash = {}
    user_poem_hash[@user_poem.keyword_source] = @user_poem.keyword_source_id
    summary_hash[@summary] = user_poem_hash
    summary_hash
  end

  def holiday_summary
    holiday_name = @user_poem.keyword_text.titleize
    @summary << "because today is #{holiday_name}. "
    if Date.today.month = 12 && Date.today.day == 25
      @summary << "Merry Christmas!"
    else
      @summary << "Happy #{holiday_name}!"
    end
  end

  def forecast_summary
    @summary << "which is in today's forecast for #{@user_poem.keyword_source_id}."
  end

  def news_summary
    @summary << "which was in"
  end

  def twitter_summary
    @summary << "which was in"
  end

end