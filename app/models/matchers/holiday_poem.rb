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
    set_holiday
    add_to_keyword_collection
    
    KeywordSearch.new(@keywords).match_keywords_to_poems
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

end
