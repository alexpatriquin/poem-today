class PoemMailer < ActionMailer::Base
  default from: "hello@poemtoday.com"

  def daily_email(user)
    @user = user
    @poem = PoemMatcher.new(user).match_poem
    @url  = 'http://poemtoday.com/'
    mail(to: @user.email, subject: 'Today\'s Poem')
  end

end
