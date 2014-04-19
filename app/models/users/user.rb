class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create :first_poem

  has_many :user_poems
  has_many :poems, :through => :user_poems
  has_many :forecasts

  geocoded_by :location
  after_validation :geocode, :if => :location_changed?

  private 
  def first_poem
    PoemMatcher.new(self).first_name_match
  end
end
