class HolidayPoem

  HOLIDAYS_2014 = { 
  "Christmas"         => "2014-12-25",
  "Alex's Birthday"   => "2014-04-19",
  "Cinco de Mayo"     => "2014-05-05",
  "Father's Day"      => "2014-06-15",
  "Halloween"         => "2014-10-31",
  "Independence Day"  => "2014-07-04",
  "Labor Day"         => "2014-09-01",
  "Memorial Day"      => "2014-06-26",
  "Mother's Day"      => "2014-05-11",
  "New Years Eve"     => "2014-12-31",
  "Code Day"          => "2014-04-15",
  "Thanksgiving"      => "2014-11-27" 
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
    @holiday = holiday.keys
  end

  def add_to_keyword_collection
    @keywords = []
    source = :holiday
    @holiday.each do |keyword|
      @keywords << Keyword.new(keyword, 0, source)
    end 
  end

  def match_keywords_to_poems  
    @keywords.each do |keyword|
      keyword.poems << Poem.search_by_subject(keyword.text).map    { |poem| { :id => poem.id, :match_type => :subject    }}
      keyword.poems << Poem.search_by_occasion(keyword.text).map    { |poem| { :id => poem.id, :match_type => :occasion    }}
      keyword.poems << Poem.search_by_title(keyword.text).map      { |poem| { :id => poem.id, :match_type => :title      }}
      keyword.poems << Poem.search_by_first_line(keyword.text).map { |poem| { :id => poem.id, :match_type => :first_line }}
      # keyword.poems << Poem.search_by_content(keyword.text).map    { |poem| { :id => poem.id, :match_type => :content    }}
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
