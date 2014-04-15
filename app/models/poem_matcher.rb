class PoemMatcher

  Holidays = []

  def initialize(user)
    @user = user    
  end

  def match_poem
    @results = []
    
    forecast_matches   = ForecastPoem.new(@user).build_collection
    @results           << PoemScorer.new.score_results(forecast_matches)

    news_matches       = NewsPoem.new(@user).build_collection
    @results           << PoemScorer.new.score_results(news_matches)

    if @user.twitter_handle != nil
      tweet_matches      = TweetPoem.new(@user).build_collection
      @results           << PoemScorer.new.score_results(tweet_matches)
    end
    
    @results.flatten!
    ensure_results
    save_top_result
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






