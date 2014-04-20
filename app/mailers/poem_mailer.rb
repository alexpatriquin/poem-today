class PoemMailer < ActionMailer::Base
  default from: "hello@poemtoday.com"

  def daily_email(user)
    @user = user
    @poem = PoemMatcher.new(user).match_poem
    @poem_url  = "http://poemtoday.com#{poem_path(user.user_poems.last.poem_id)}"
    mail(to: @user.email, subject: 'Today\'s Poem')

    if @user.twitter_handle
      TWITTER_CLIENT.update("Good morning @#{@user.twitter_handle}, here is your poem for today. #{@poem_url}")
    end
  end

end
