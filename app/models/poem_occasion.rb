class PoemOccasion < ActiveRecord::Base
    belongs_to :poem
    belongs_to :occasion
end
