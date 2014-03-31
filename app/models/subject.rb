class Subject < ActiveRecord::Base
    has_many :poem_subjects
    has_many :poems, :through => :poem_subjects
end
