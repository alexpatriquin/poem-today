class PoemMatcher

  HOLIDAYS_2014 = { 
    "christmas"         => "2014-12-25",
    "alex's birthday"   => "2014-04-19",
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

  POEM_MATCHERS = {
   "first_name" => FirstNamePoem,
   "birthday"   => BirthdayPoem,
   "holiday"    => HolidayPoem,
   "forecast"   => ForecastPoem,
   "news"       => NewsPoem,
   "tweet"      => TweetPoem
  }

  def initialize(user)
    @user = user    
  end

  def first_name_match
    @results = []
    data_source_match("first_name")
    @results.flatten!
    ensure_not_empty
    save_top_result
  end

  def match_poem
    @results = []
    
    if @user.birthday && user_birthday_today
      data_source_match("birthday")
    else holiday_today
      data_source_match("holiday")
    end

    data_source_match("forecast") if @user.latitude.present? && @user.longitude.present? 
    data_source_match("news")
    data_source_match("tweet") if @user.twitter_handle.present?

    @results.flatten!
    ensure_results
    save_top_result
  end

  def user_birthday_today
    (@user.birthday.month == Date.today.month) && (@user.birthday.day == Date.today.day)
  end
  
  def holiday_today
    HOLIDAYS_2014.values.include?(Date.today.to_s)
  end

  def data_source_match(data_source)
    poem_matches = POEM_MATCHERS[data_source].new(@user).build_collection
    @results << PoemScorer.new.score_results(poem_matches)
  end

  def ensure_results
    #breaks without enough poems
    ensure_not_empty
    ensure_unique
  end

  def ensure_not_empty
    if @results.empty?
      poem_hash                      = {}
      poem_hash[:poem_id]            = Poem.find(rand(1..Poem.count)).id
      poem_hash[:match_type]         = "random"
      poem_hash[:match_score]        = 0
      @results << poem_hash
      
      ensure_unique
    end
  end

  def ensure_unique
    user_keyword_history = UserPoem.where(user_id: @user.id).pluck(:keyword_text)
    user_keyword_history.delete_if { |keyword| keyword == nil }
    user_keyword_history.each do |keyword|
      @results.delete_if { |result| result[:keyword_text] == keyword }
    end

    user_poem_history = UserPoem.where(user_id: @user.id).pluck(:poem_id)
    user_poem_history.each do |poem_id|
      @results.delete_if { |result| result[:poem_id] == poem_id }
    end

    ensure_not_empty
  end

  def save_top_result
    top_result = @results.inject do |winning,result| 
      winning[:match_score] > result[:match_score] ? winning : result 
    end
    user_poem = @user.user_poems.build(:poem_id   => top_result[:poem_id],
                             :match_score         => top_result[:match_score],
                             :keyword_text        => top_result[:keyword_text],
                             :keyword_frequency   => top_result[:keyword_frequency],
                             :keyword_source      => top_result[:keyword_source],
                             :keyword_source_id   => top_result[:keyword_source_id],
                             :match_type          => top_result[:match_type])
    @user.save
    
    user_poem.create_summary_past_tense
    user_poem
  end

end






