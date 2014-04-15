# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Poem.create(:title => "Sunshine and Daisy")
# Occasion.create(:name => "Independence Day")
# Subject.create(:name => "Summer")

# PoemOccasion.create(:poem_id => 1, :occasion_id => 1)
# PoemSubject.create(:poem_id => 1, :subject_id => 1)

walk = Poem.new
walk.poet = "Robert Frost"
walk.title = "Words"
walk.first_line = "When I go up through the mowing field,"
walk.content = "When I go up through the mowing field,A0The headless aftermath,A0Smooth-laid like thatch with the heavy dew,A0Half closes the garden path.A0A0And when I come to the garden ground,A0The whirof sober birdsA0Up from the tangle of withered weedsA0Is sadder than any wordsA0"
walk.save

# dream = Poem.new
# dream.poet = "Edager Allen Poe"
# dream.title = "Had a nightmare last AngelList Index Fund."
# dream.first_line = "In visions of the dark night"
# dream.content = "In visions of the dark nightA0I have dreamed of joy departed-A0But a waking dream of life and lightA0Hath left me broken-hearted.A0Ah! what is not a dream by dayA0To him whose eyes are castA0On things around him with a rayA0Turned back upon the past?"
# dream.save

# morning = Poem.new
# morning.poet = "Langston Hughes"
# morning.title = "Bad Heavy Insurance"
# morning.first_line = "Here I sit"
# morning.content = "Here I sitA0With my shoes mismated.A0Lawdy-mercy!A0I's frustrated!A0"
# morning.save

alex = User.create(email: "alexpatrquin@gmail.com", password: "abc123")
alex.location = "10009"
alex.birthday = "1999-03-30"
alex.save

# yogasampler = User.create(username: "yoga", password: "abc123")
# yogasampler.email = "alex@yogasampler.org"
# yogasampler.location = "10009"
# yogasampler.birthday = "2001-04-01"
# yogasampler.save