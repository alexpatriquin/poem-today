class PoemMatcher

  def initialize(user)
    @user = user    
  end

  def match_poem
    setup_results_hash
    # special_occasions, otherwise:
    # score_by_tweets
    # score_by_news
    score_by_forecast
    ensure_results
    save_top_result
  end

  def setup_results_hash
    @results = {}
  end

  def score_by_forecast
    ForecastPoem.new(@user).build_collection.each do |poem_id|
      @results[poem_id] = 0
      @results[poem_id] += 20
    end
  end

  def ensure_results
    ensure_not_empty
    ensure_unique
  end

  def ensure_not_empty
    if @results.empty?
      random_poem_id = Poem.find(rand(1..Poem.count)).id
      @results[random_poem_id] = 0
      ensure_unique
    end
  end

  def ensure_unique
    @user_poem_history ||= UserPoem.where(:user_id => @user.id).pluck(:poem_id)
    @results.keys.each do |poem_id|
        @results.delete(poem_id) if @user_poem_history.include?(poem_id)
    end
    ensure_not_empty
  end

  def save_top_result
    id = @results.sort_by { |poem_id, score| score }.reverse.first.first
    top_result = Poem.find(id)
    @user.poems << top_result
    top_result
  end

end


# To Do
# if it's a birthday or a holiday, return those poems only and pick at random
# otherwise, score for tweets, news and forecast in that order

# put language into a module
# common words and synonyms
# https://github.com/roja/words
# https://github.com/doches/rwordnet
# https://github.com/yohasebe/engtagger

    










