class PoemMailer < ActionMailer::Base
  default from: "from@example.com"

  def daily_email(user)
    @user = user
    @poem = UserPoem.new(user).match_poem
    @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Today\'s Poem')
  end
end
