class TweetPoem

  def initialize(user)
    @user = user
  end

  def build_collection
    @matches = []

    call_twitter_api
    save_past_day_tweets

    add_to_keyword_collection
    match_keywords_to_poems
    save_poems_to_results
    @matches
  end

  def call_twitter_api
    num_of_tweets = 5
    binding.pry
    @payload  = TWITTER_CLIENT.search("from:#{@user.twitter_handle}", :result_type => "recent").take(num_of_tweets)
  end

  def save_past_day_tweets
    @payload.delete_if { |tweet| tweet.created_at < (Time.now - 24.hours)}
    @payload.each      { |tweet| Tweet.create(:user_id  => @user.id, :text => tweet.text, :id_str => tweet.id.to_s) }
  end

  def add_to_keyword_collection
    @keywords = []
    source = :twitter
    @payload.each do |tweet|
      tweet.text.downcase.gsub(/’s|[^a-z\s]/,'').split.uniq.each do |keyword|
        frequency = call_wordnik_api(keyword)
        if !frequency.nil? && frequency > 0 && frequency < 1000
          infreq_word = Keyword.new(keyword, frequency, source)
          infreq_word.source_id = tweet.id.to_s
          @keywords << infreq_word
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

  def match_keywords_to_poems  
    @keywords.each do |keyword|
      keyword.poems << Poem.search_by_occasion(keyword.text).map    { |poem| { :id => poem.id, :match_type => :occasion    }}
      keyword.poems << Poem.search_by_subject(keyword.text).map    { |poem| { :id => poem.id, :match_type => :subject    }}
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
