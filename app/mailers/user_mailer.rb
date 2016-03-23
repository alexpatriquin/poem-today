class UserMailer < ActionMailer::Base
  default from: "from@example.com"

   def welcome_email(user)
    @user = user
    @url  = 'http://poemtoday.com/'
    mail(to: @user.email, subject: 'Welcome to PoemToday')
  end
end
