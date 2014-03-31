# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Poem.create(:title => "Sunshine and Daisy")
Occasion.create(:name => "Independence Day")
Subject.create(:name => "Summer")

PoemOccasion.create(:poem_id => 1, :occasion_id => 1)
PoemSubject.create(:poem_id => 1, :subject_id => 1)
