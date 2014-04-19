class Poem < ActiveRecord::Base
    has_many :user_poems
    has_many :users, :through => :user_poems
    has_many :poem_subjects
    has_many :subjects, :through => :poem_subjects
    has_many :poem_occasions
    has_many :occasions, :through => :poem_occasions

  include PgSearch
  pg_search_scope :search_by_occasion,    :associated_against => {:occasions => :name},     :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_subject,     :associated_against => {:subjects  => :name},     :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_title,       :against => [:title],                             :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_first_line,  :against => [:first_line],                        :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_content,     :against => [:content],                           :using => {:tsearch => {:dictionary => "english"}}
  pg_search_scope :search_by_poet,        :against => [:poet],                              :using => {:tsearch => {:dictionary => "english"}}

end
