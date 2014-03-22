class PoemMailer < ActionMailer::Base
  default from: "hello@poemtoday.com"

  def daily_email(user)
    @user = user
    @poem = UserPoem.new(user).match_poem
    @url  = 'http://poemtoday.com/'
    mail(to: @user.email, subject: 'Today\'s Poem')
  end

end
