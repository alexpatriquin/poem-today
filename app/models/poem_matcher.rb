class PoemMatcher

  def initialize(user)
    @user = user    
  end

  def match_poem
    
    # special_occasions, otherwise:
    # score_by_tweets
    
    # NewsPoem.new(@user).build_collection
    forecast_results = ForecastPoem.new(@user).build_collection
    @results = PoemScorer.new.score_results(forecast_results)

    # ensure_results
    save_top_result
  end

  # def ensure_results
  #   #breaks without enough poems
  #   ensure_not_empty
  #   ensure_unique
  # end

  # def ensure_not_empty
  #   if RESULTS.empty?
  #     random_poem_id = Poem.find(rand(1..Poem.count)).id
  #     @results[random_poem_id] = 0
  #     ensure_unique
  #   end
  # end

  # def ensure_unique
  #   @user_poem_history ||= UserPoem.where(:user_id => @user.id).pluck(:poem_id)
  #   @results.keys.each do |poem_id|
  #       @results.delete(poem_id) if @user_poem_history.include?(poem_id)
  #   end
  #   ensure_not_empty
  # end

  def save_top_result
    top_result = @results.inject { |winning,result| winning[:match_score] > result[:match_score] ? winning : result }

    @user.user_poems.build(:poem_id             => top_result[:poem_id],
                           :match_score         => top_result[:match_score],
                           :keyword_text        => top_result[:keyword_text],
                           :keyword_frequency   => top_result[:keyword_frequency])
                           # :keyword_source     => top_result[:keyword_source]
                           # :keyword_match_type => top_result[:keyword_match_type]
    @user.save
    Poem.find(top_result[:poem_id])
  end

end






