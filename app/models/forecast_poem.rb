class ForecastPoem

  def initialize(user)
    @user = user
  end

  def build_collection
    KEYWORDS.clear

    lat = @user.latitude
    long = @user.longitude
    call_forecastio_api(lat,long)
    parse_forecastio_api

    extract_forecast_keywords
    add_to_keyword_collection

    match_forecast_keywords_to_poems
    save_poems_to_results
  end

  def call_forecastio_api(lat,long)
    @payload = ForecastIO.forecast(lat,long)
  end

 def parse_forecastio_api
    @summary = @payload["daily"]["data"][0]["summary"]
  end

  def extract_forecast_keywords
    @keywords = @summary.delete('.').downcase.gsub(/’s|[^a-z\s]/,' ').split.uniq
  end

  def add_to_keyword_collection
    @keywords.each do |keyword|
      frequency = call_wordnik_api(keyword)
      KEYWORDS << Keyword.new(keyword, frequency)
    end 
  end

  def call_wordnik_api(keyword)
    uri = "http://api.wordnik.com/v4/word.json/#{keyword}/frequency?useCanonical=true&startYear=2000&endYear=2012&api_key=#{ENV["WORDNIK_API_KEY"]}"
    parsed_uri = URI.parse(uri)
    response = Net::HTTP.get_response(parsed_uri)
    JSON.parse(response.body)["totalCount"]
  end

  def match_forecast_keywords_to_poems  
    KEYWORDS.each do |keyword|
      keyword.poems << Poem.search_by_subject(keyword.keyword_text).map    { |poem| { :id => poem.id, :match_type => [:subject] }}
      keyword.poems << Poem.search_by_title(keyword.keyword_text).map      { |poem| { :id => poem.id, :match_type => [:title] }}
      keyword.poems << Poem.search_by_first_line(keyword.keyword_text).map { |poem| { :id => poem.id, :match_type => [:first_line] }}
      keyword.poems << Poem.search_by_content(keyword.keyword_text).map    { |poem| { :id => poem.id, :match_type => [:content] }}
      keyword.poems.flatten!
    end
  end

  def save_poems_to_results
    KEYWORDS.each do |keyword|
      keyword.poems.each do |poem|
        poem_hash                     = {}
        poem_hash[:poem_id]           = poem[:id]
        poem_hash[:match_type]        = poem[:match_type]        
        poem_hash[:keyword_text]      = keyword.keyword_text
        poem_hash[:keyword_frequency] = keyword.frequency
        poem_hash[:keyword_source]    = [:forecast]
        RESULTS << poem_hash
      end
    end
  end

end












