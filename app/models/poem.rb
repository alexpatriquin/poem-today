class Poem < ActiveRecord::Base
  has_many :user_poems
  has_many :users, :through => :user_poems

  include PgSearch
  pg_search_scope :search_by_occasion,    :against => [:occasion],   :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_holiday,     :against => [:holiday],    :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_subject,     :against => [:subject],    :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_title,       :against => [:title],      :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_first_line,  :against => [:first_line], :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_content,     :against => [:content],    :using => {:tsearch => {:dictionary => "english"}}

end
