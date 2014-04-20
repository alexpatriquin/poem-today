class ForecastPoem

  def initialize(user)
    @user = user
  end

  def build_collection    
    lat = @user.latitude
    long = @user.longitude
    call_forecastio_api(lat,long)
    save_forecast_summary
    parse_forecastio_api
    add_to_keyword_collection

    KeywordSearch.new(@keywords).match_keywords_to_poems
  end

  def call_forecastio_api(lat,long)
    uri = "https://api.forecast.io/forecast/#{ENV["FORECAST_IO_APIKEY"]}/#{lat},#{long}"
    uri = "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/all-sections/1.json?api-key=#{ENV["NYT_APIKEY"]}"
    parsed_uri = URI.parse(uri)
    response = Net::HTTP.get_response(parsed_uri)
    @payload = JSON.parse(response.body)
  end

  def save_forecast_summary
    @summary = @payload["daily"]["data"][0]["summary"]
    min_temp = @payload["daily"]["data"][0]["apparentTemperatureMin"].round
    max_temp = @payload["daily"]["data"][0]["apparentTemperatureMax"].round
    Forecast.create(:user_id  => @user.id,
                    :summary  => @summary, 
                    :min_temp => min_temp,
                    :max_temp => max_temp)
  end

  def parse_forecastio_api
    @summary_words = @summary.delete('.').downcase.gsub(/’s|[^a-z\s]/,' ').split.uniq
  end

  def add_to_keyword_collection
    @keywords = []
    source = :forecast
    @summary_words.each do |keyword|
      frequency = call_wordnik_api(keyword)
      if !frequency.nil? && frequency > 0 && frequency < 1000
        @keywords << Keyword.new(keyword, frequency, source, @user.location)
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
