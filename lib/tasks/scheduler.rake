namespace :pt do

  task :pt_env do
    ENV["RAILS_ENV"] ||= 'production'
    require File.expand_path("../../../config/environment", __FILE__)
    Bundler.require(:default)
  end

  desc "Send the daily emails to all users"
  task :email_users => [:pt_env] do
    begin
      User.all.each { |u| PoemMailer.daily_email(u).deliver }
    rescue LoadError
      puts "Couldn't send to last email"
      next
    end
  end

  desc "Send a test email to admin"
  task :email_admin => [:pt_env] do
    u = User.find_by_email("alexpatriquin@gmail.com")
    PoemMailer.daily_email(u).deliver
    puts "Email sent to admin"
  end

end