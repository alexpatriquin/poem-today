alex = User.create(email: "alexpatrquin@gmail.com", password: "abc123", password_confirmation: "abc123")
alex.first_name = "Alex"
alex.birthday = Date.today
alex.twitter_handle = "apatriq"
alex.location = "10009"
alex.save

