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

  def initialize(user)
    @user = user    
  end

  def match_poem
    @results = []
    
    if user_created_today && @user.first_name
      first_name_match 
    elsif @user.birthday && user_birthday_today 
      birthday_match
      first_name_match
    elsif holiday_today
      holiday_match
    else
      forecast_match
      news_match
      tweet_match
    end

    @results.flatten!
    ensure_results
    save_top_result
  end

  def user_created_today
    @user.created_at.month == Date.today.month && @user.created_at.month == Date.today.month
  end

  def first_name_match
    first_name_matches = FirstNamePoem.new(@user).build_collection
    @results << PoemScorer.new.score_results(first_name_matches)
  end

  def user_birthday_today
    @user.birthday == Date.today
  end

  def birthday_match
    birthday_matches = BirthdayPoem.new(@user).build_collection
    @results << PoemScorer.new.score_results(birthday_matches)
  end
  
  def holiday_today
    HOLIDAYS_2014.values.include?(Date.today.to_s)
  end

  def holiday_match
    holiday_matches = HolidayPoem.new(@user).build_collection
    @results << PoemScorer.new.score_results(holiday_matches)
  end

  def forecast_match
    forecast_matches = ForecastPoem.new(@user).build_collection
    @results << PoemScorer.new.score_results(forecast_matches)
  end

  def news_match
    news_matches = NewsPoem.new(@user).build_collection
    @results << PoemScorer.new.score_results(news_matches)
  end

  def tweet_match
    if @user.twitter_handle != nil
      tweet_matches  = TweetPoem.new(@user).build_collection
      @results << PoemScorer.new.score_results(tweet_matches)
    end
  end

  def ensure_results
    #breaks without enough poems
    ensure_not_empty
    ensure_unique
  end

  def ensure_not_empty
    if @results.empty?
      poem_hash                      = {}
      #improve this...
      poem_hash[:poem_id]            = Poem.find(rand(1..Poem.count)).id
      poem_hash[:match_type]         = :random        
      poem_hash[:match_score]        = 0
      @results << poem_hash
      
      ensure_unique
    end
  end

  def ensure_unique
    @user_poem_history ||= UserPoem.where(:user_id => @user.id).pluck(:poem_id)
    @results.each do |result| 
      # binding.pry
      @results.delete(result) if @user_poem_history.include?(result[:poem_id]) 
    end
    ensure_not_empty
  end

  def save_top_result
    top_result = @results.inject do |winning,result| 
      winning[:match_score] > result[:match_score] ? winning : result 
    end
    @user.user_poems.build(:poem_id             => top_result[:poem_id],
                           :match_score         => top_result[:match_score],
                           :keyword_text        => top_result[:keyword_text],
                           :keyword_frequency   => top_result[:keyword_frequency],
                           :keyword_source      => top_result[:keyword_source],
                           :keyword_source_id   => top_result[:keyword_source_id],
                           :match_type          => top_result[:match_type])
    @user.save
    Poem.find(top_result[:poem_id])
  end

end






