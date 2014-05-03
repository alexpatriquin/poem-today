class PoemMailer < ActionMailer::Base
  default from: "hello@poemtoday.com"

  def daily_email(user)
    @user = user
    @user_poem = PoemMatcher.new(user).match_poem
    @poem = Poem.find(@user_poem.poem_id)
    create_summary_present_tense
    create_forecast

    mail(to: @user.email, subject: "#{@poem.title}")

    if @user.twitter_handle.present?
      TWITTER_CLIENT.update("Good morning @#{@user.twitter_handle}, here is your poem for today. http://www.poemtoday.com/poems/#{@poem.id}?keyword=#{@user_poem.keyword_text}")
    end
  end

  def create_forecast
    if @user.forecasts.present? && (@user.forecasts.last.created_at > Time.now.beginning_of_day)
      @forecast = "#{@user.forecasts.last.summary} Min: #{@user.forecasts.last.min_temp} F, Max: #{@user.forecasts.last.max_temp} F."
    end
  end

  def create_summary_present_tense
    summary_hash = {}
    @summary = "You were matched to this poem "

    if @user_poem.match_type == "random"
      @summary << "with a random word."
    else
    
      @summary << "with the word \"#{@user_poem.keyword_text}\" "
      case @user_poem.keyword_source
      when :first_name
        @summary << "because that's your name ;)"
      when :birthday
        @summary << "because today's your birthday. Happy birthday!"
      when :holiday
        holiday_name = @user_poem.keyword_text.titleize
        @summary << "because today is #{holiday_name}. Happy #{holiday_name}!"
      when "forecast"
        @summary << "which appears in today's forecast."
      when :news
        @summary << "which appears in"
      when :twitter
        @summary << "which appears in"
      end
    end
    user_poem_hash = {}
    user_poem_hash[@user_poem.keyword_source] = @user_poem.keyword_source_id
    summary_hash[@summary] = user_poem_hash
    summary_hash
  end

end