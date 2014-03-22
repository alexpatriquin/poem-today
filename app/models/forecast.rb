class Forecast
  COMMON_WORDS = ["throughout", "the", "day"]    

  def get_forecast_keywords(user)
    lat = user.latitude
    long = user.longitude
    call_forecastio_api(lat,long)
    
    parse_forecastio_api
    extract_forecast_keywords
  end

  def call_forecastio_api(lat,long)
    @payload = ForecastIO.forecast(lat,long)
  end

  def parse_forecastio_api
    @summary = @payload["daily"]["data"][0]["summary"]
  end

  def extract_forecast_keywords
    @summary.delete('.').split.delete_if { |w| COMMON_WORDS.include?(w) }
  end


end