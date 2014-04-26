class PoemMailer < ActionMailer::Base
  default from: "hello@poemtoday.com"

  def daily_email(user)
    @user = user
    @poem = PoemMatcher.new(user).match_poem
    @poem_url = "http://poemtoday.com#{poem_path(@poem)}"
    
    user_poem          = @user.user_poems.last
    @keyword_text      = user_poem.keyword_text || @poem.title.split.first #protects random
    @match_score       = user_poem.match_score
    @match_type        = user_poem.match_type
    @keyword_source    = user_poem.keyword_source
    @keyword_source_id = user_poem.keyword_source_id

    mail(to: @user.email, subject: "#{@poem.title}")

    if twitter_handle_present?
      TWITTER_CLIENT.update("Good morning @#{@user.twitter_handle}, here is your poem for today. #{@poem_url}?#{@keyword_text}")
    end
  end

  def twitter_handle_present?
    !@user.twitter_handle.nil? && !@user.twitter_handle.empty?
  end
end
