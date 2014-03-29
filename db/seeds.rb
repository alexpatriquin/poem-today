# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

walk = Poem.new
walk.poet = "Robert Frost"
walk.title = "A Rain Cloudy Walk"
walk.first_line = "When I go up through the mowing field,"
walk.content = "When I go up through the mowing field,A0The headless aftermath,A0Smooth-laid like thatch with the heavy dew,A0Half closes the garden path.A0A0And when I come to the garden ground,A0The whirof sober birdsA0Up from the tangle of withered weedsA0Is sadder than any wordsA0"
walk.save

dream = Poem.new
dream.poet = "Edager Allen Poe"
dream.title = "A Cloudy Insurance Dream"
dream.first_line = "In visions of the dark night"
dream.content = "In visions of the dark nightA0I have dreamed of joy departed-A0But a waking dream of life and lightA0Hath left me broken-hearted.A0Ah! what is not a dream by dayA0To him whose eyes are castA0On things around him with a rayA0Turned back upon the past?"

morning = Poem.new
morning.poet = "Langston Hughes"
morning.title = "Bad Heavy Rain Insurance"
morning.first_line = "Here I sit"
morning.content = "Here I sitA0With my shoes mismated.A0Lawdy-mercy!A0I's frustrated!A0"

alex = User.new
alex.email = "alexpatrquin@gmail.com"
alex.zipcode = 10009

yogasampler = User.new
yogasampler.email = "alex@yogasampler.org"
yogasampler.zipcode = 10009

# alex.user_poems.build(:poem => dream)
# yogasampler.poems << morning

dream.save
morning.save

alex.save
yogasampler.save