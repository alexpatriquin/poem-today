class TweetPoem

  def initialize(user)
    @user = user
  end

  def build_collection
    call_twitter_api
    save_past_day_tweets
    add_to_keyword_collection

    KeywordSearch.new(@keywords).match_keywords_to_poems
  end

  def call_twitter_api
    num_of_tweets = 5
    @payload  = TWITTER_CLIENT.search("from:#{@user.twitter_handle}", :result_type => "recent").take(num_of_tweets)
  end

  def save_past_day_tweets
    @payload.delete_if { |tweet| tweet.created_at < (Time.now - 24.hours)}
    @payload.each      { |tweet| Tweet.create(:user_id  => @user.id, :text => tweet.text, :id_str => tweet.url.to_s) }
  end

  def add_to_keyword_collection
    @keywords = []
    source = :twitter
    @payload.each do |tweet|
      tweet.text.downcase.gsub(/’s|[^a-z\s]/,'').split.uniq.each do |keyword|
        frequency = call_wordnik_api(keyword)
        if !frequency.nil? && frequency > 0 && frequency < 1000
          @keywords << Keyword.new(keyword, frequency, source, tweet.url.to_s)
        end
      end
    end
  end

  def call_wordnik_api(keyword)
    start_year = 2000
    end_year = 2012 #latest
    uri = "http://api.wordnik.com/v4/word.json/#{keyword}/frequency?useCanonical=true&startYear=#{start_year}&endYear=#{end_year}&api_key=#{ENV["WORDNIK_API_KEY"]}"
    parsed_uri = URI.parse(uri)
    response = Net::HTTP.get_response(parsed_uri)
    JSON.parse(response.body)["totalCount"]
  end

end
