class ForecastPoem
  include ProcessKeywords

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
    @summary = @payload["daily"]["data"][0]["summary"].split
  end

  def extract_forecast_keywords
    @keywords = @summary.extract_keywords
  end

  def match_forecast_keywords_to_poems
    all_matches = []
    @keywords.match_keywords
    all_matches.flatten.uniq
  end

end