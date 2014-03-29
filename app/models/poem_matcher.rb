class PoemMatcher

  RESULTS = []

  def initialize(user)
    @user = user    
  end

  def match_poem
    RESULTS.clear
    
    # special_occasions, otherwise:
    # score_by_tweets
    
    # NewsPoem.new(@user).build_collection
    ForecastPoem.new(@user).build_collection

    # ensure_results
    # save_top_result
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

  # def save_top_result
  #   top_result = @results.sort_by { |poem_id, score| score }.reverse.first
  #   @user.user_poems.build(:poem_id => top_result[0], :match_score => top_result[1])
  #   @user.save
  #   Poem.find(top_result[0])
  # end

end






