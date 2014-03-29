class ForecastPoem

  def initialize(user)
    @user = user
  end

  def build_collection
    @results = []
    lat = @user.latitude
    long = @user.longitude
    call_forecastio_api(lat,long)
    parse_forecastio_api

    add_to_keyword_collection

    match_keywords_to_poems
    save_poems_to_results
    @results
  end

  def call_forecastio_api(lat,long)
    @payload = ForecastIO.forecast(lat,long)
  end

 def parse_forecastio_api
    @summary_words = @payload["daily"]["data"][0]["summary"].delete('.').downcase.gsub(/’s|[^a-z\s]/,' ').split.uniq
  end

  def add_to_keyword_collection
    @keywords = []
    @summary_words.each do |keyword|
      frequency = call_wordnik_api(keyword)
      @keywords << Keyword.new(keyword, frequency) if frequency < 1000
    end 
  end

  def call_wordnik_api(keyword)
    uri = "http://api.wordnik.com/v4/word.json/#{keyword}/frequency?useCanonical=true&startYear=2000&endYear=2012&api_key=#{ENV["WORDNIK_API_KEY"]}"
    parsed_uri = URI.parse(uri)
    response = Net::HTTP.get_response(parsed_uri)
    JSON.parse(response.body)["totalCount"]
  end

  def match_keywords_to_poems  
    @keywords.each do |keyword|
      keyword.poems << Poem.search_by_subject(keyword.keyword_text).map    { |poem| { :id => poem.id, :match_type => [:subject] }}
      keyword.poems << Poem.search_by_title(keyword.keyword_text).map      { |poem| { :id => poem.id, :match_type => [:title] }}
      keyword.poems << Poem.search_by_first_line(keyword.keyword_text).map { |poem| { :id => poem.id, :match_type => [:first_line] }}
      keyword.poems << Poem.search_by_content(keyword.keyword_text).map    { |poem| { :id => poem.id, :match_type => [:content] }}
      keyword.poems.flatten!
    end
  end

  def save_poems_to_results
    @keywords.each do |keyword|
      keyword.poems.each do |poem|
        poem_hash                       = {}
        poem_hash[:poem_id]             = poem[:id]
        poem_hash[:match_type]         = poem[:match_type]        
        poem_hash[:keyword_text]        = keyword.keyword_text
        poem_hash[:keyword_frequency]   = keyword.frequency
        poem_hash[:keyword_source]     = [:forecast]
        @results << poem_hash
      end
    end
  end

end
