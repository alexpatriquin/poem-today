require 'open-uri'

class NewsPoem

  def initialize(user)
    @user = user
  end

  def build_collection
    call_nyt_api
    take_top_articles
    save_top_articles
    add_to_keyword_collection
    
    KeywordSearch.new(@keywords).match_keywords_to_poems
  end

  def call_nyt_api
    uri = "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/all-sections/1.json?api-key=#{ENV["NYT_APIKEY"]}"
    parsed_uri = URI.parse(uri)
    response = Net::HTTP.get_response(parsed_uri)
    @payload = JSON.parse(response.body)
  end

  def take_top_articles
    num_of_articles = 3
    @title_urls = @payload["results"][1..num_of_articles].map do |article| 
                    { :title => article["title"], :url => article["url"] }
                  end
  end

  def save_top_articles
    @title_urls.each { |tu| News.create!(:user_id  => @user.id, :title => tu[:title], :url => tu[:url]) }
  end

  def add_to_keyword_collection
    @keywords = []
    source = :news
    @title_urls.each do |hash|
      keywords = hash[:title].downcase.gsub(/’s|[^a-z\s]/,'').split.uniq
      keywords.each do |keyword|
        frequency = call_wordnik_api(keyword)
        if !frequency.nil? && frequency > 0 && frequency < 1000
          @keywords << Keyword.new(keyword, frequency, source, hash[:url])
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
