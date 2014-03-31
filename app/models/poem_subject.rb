class PoemSubject < ActiveRecord::Base
    belongs_to :poem
    belongs_to :subject
end
