alex = User.create(email: "alexpatrquin@gmail.com", password: "abc123", password_confirmation: "abc123")
alex.first_name = "Alex"
alex.birthday = Date.today
alex.twitter_handle = "apatriq"
alex.location = "10009"
alex.save

yoga = User.create(email: "alex@yogasampler.org.com", password: "abc123", password_confirmation: "abc123")
yoga.first_name = "Alex"
yoga.birthday = Date.today + 3
yoga.twitter_handle = "yogasampler"
yoga.location = "02472"
yoga.save

