require 'open-uri'

class NewsPoem
  include ProcessKeywords

  def initialize(user)
    @user = user
  end

  def build_collection
    call_nyt_api
    parse_nyt_api
    extract_article_keywords
    match_news_keywords_to_poems
  end

  def call_nyt_api
    uri = "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/all-sections/1.json?api-key=#{ENV["NYT_APIKEY"]}"
    parsed_uri = URI.parse(uri)
    response = Net::HTTP.get_response(parsed_uri)
    @payload = JSON.parse(response.body)
  end

  def parse_nyt_api
    titles = []
    abstracts = []
    number_of_articles = 10
    @payload["results"][1..number_of_articles].each do |article|
      titles << article["title"]
      abstracts << article["abstract"]
    end
    @summary = titles + abstracts
  end

  def extract_article_keywords
    @keywords = @summary.extract_keywords
  end

  def match_news_keywords_to_poems
    all_matches = []
    @keywords.match_keywords
    all_matches.flatten.uniq
  end

end