class User < ActiveRecord::Base
  has_many :user_poems
  has_many :poems, :through => :user_poems

  geocoded_by :zipcode
  after_validation :geocode, :if => :zipcode_changed?
end
