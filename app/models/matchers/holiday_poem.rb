class HolidayPoem

  HOLIDAYS_2014 = { 
    "christmas"         => "2014-12-25",
    "alex's birthday"   => "2014-04-18",
    "cinco de mayo"     => "2014-05-05",
    "father's day"      => "2014-06-15",
    "halloween"         => "2014-10-31",
    "independence day"  => "2014-07-04",
    "labor day"         => "2014-09-01",
    "memorial day"      => "2014-06-26",
    "mother's day"      => "2014-05-11",
    "new years eve"     => "2014-12-31",
    "thanksgiving"      => "2014-11-27" 
  }

  def initialize(user)
    @user = user
  end

  def build_collection
    @matches = []

    set_holiday

    add_to_keyword_collection
    match_keywords_to_poems
    save_poems_to_results
    @matches
  end

  def set_holiday
    holiday = HOLIDAYS_2014.select { |holiday,date| holiday if date == Date.today.to_s }
    @holidays = holiday.keys
  end

  def add_to_keyword_collection
    @keywords = []
    source = :holiday
    @holidays.each do |keyword|
      @keywords << Keyword.new(keyword, 0, source, keyword)
    end 
  end

  def match_keywords_to_poems  
    @keywords.each do |keyword|
      keyword.poems << Poem.search_by_occasion(keyword.text).map    { |poem| { :id => poem.id, :match_type => :occasion    }}
      keyword.poems << Poem.search_by_poet(keyword.text).map       { |poem| { :id => poem.id, :match_type => :poet       }}
      keyword.poems << Poem.search_by_subject(keyword.text).map    { |poem| { :id => poem.id, :match_type => :subject    }}
      keyword.poems << Poem.search_by_title(keyword.text).map      { |poem| { :id => poem.id, :match_type => :title      }}
      keyword.poems << Poem.search_by_first_line(keyword.text).map { |poem| { :id => poem.id, :match_type => :first_line }}
      keyword.poems << Poem.search_by_content(keyword.text).map    { |poem| { :id => poem.id, :match_type => :content    }}
      keyword.poems.flatten!
    end
  end

  def save_poems_to_results
    @keywords.each do |keyword|
      keyword.poems.each do |poem|
        poem_hash                      = {}
        poem_hash[:poem_id]            = poem[:id]
        poem_hash[:match_type]         = poem[:match_type]        
        poem_hash[:keyword_text]       = keyword.text
        poem_hash[:keyword_frequency]  = keyword.frequency
        poem_hash[:keyword_source]     = keyword.source
        poem_hash[:keyword_source_id]  = keyword.source_id
        @matches << poem_hash
      end
    end
  end

end
