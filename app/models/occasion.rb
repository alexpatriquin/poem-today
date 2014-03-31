class Occasion < ActiveRecord::Base
    has_many :poem_occasions
    has_many :poems, :through => :poem_occasions
end
