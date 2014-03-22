class User < ActiveRecord::Base
  geocoded_by :zipcode
  after_validation :geocode, :if => :zipcode_changed?
end
