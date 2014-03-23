class ForecastPoem
  COMMON_WORDS = ["throughout", "the", "day", "mostly", "evening", "mostly", "until"]    

  def initialize(user)
    @user = user
  end

  def build_collection
    lat = @user.latitude
    long = @user.longitude
    call_forecastio_api(lat,long)
    
    parse_forecastio_api
    extract_forecast_keywords
    match_forecast_keywords_to_poems
  end

  def call_forecastio_api(lat,long)
    @payload = ForecastIO.forecast(lat,long)
  end

 def parse_forecastio_api
    @summary = @payload["daily"]["data"][0]["summary"]
  end

  def extract_forecast_keywords
    @keywords = @summary.delete('.').downcase.split.delete_if { |w| COMMON_WORDS.include?(w) }
  end

  def match_forecast_keywords_to_poems
    all_matches = []
    @keywords.each do |keyword|
      keyword_matches = Poem.where("title LIKE :keyword", {keyword: "%#{keyword}%"}).pluck(:id)
      all_matches << keyword_matches if !keyword_matches.empty?
    end
    all_matches.flatten
  end

end