walk = Poem.new(poet: "Robert Frost")
walk.subject = ""
walk.occasion = ""
walk.title = ""
walk.first_line = ""

walk.save


alex = User.create(email: "alexpatrquin@gmail.com", password: "abc123", password_confirmation: "abc123")
alex.location = "10009"
alex.birthday = "1999-03-30"
alex.save