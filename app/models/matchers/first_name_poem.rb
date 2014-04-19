class FirstNamePoem

  def initialize(user)
    @user = user
  end

  def build_collection
    parse_first_name
    add_to_keyword_collection

    KeywordSearch.new(@keywords).match_keywords_to_poems
  end

  def parse_first_name
    @parsed_name = @user.first_name.downcase.gsub(/’s|[^a-z\s]/,' ').split.uniq
  end

  def add_to_keyword_collection
    @keywords = []
    source = :first_name
    @parsed_name.each do |keyword|
      @keywords << Keyword.new(keyword, 0, source, @user.first_name)
    end 
  end

end