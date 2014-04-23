class UserPoem < ActiveRecord::Base
  belongs_to :poem
  belongs_to :user


end
