class BirthdayPoem

  BIRTHDAY_TERMS = ["birthday", "birthdays", "birthdays"]

  def initialize(user)
    @user = user
  end

  def build_collection
    add_to_keyword_collection

    KeywordSearch.new(@keywords).match_keywords_to_poems
  end

  def add_to_keyword_collection
    @keywords = []
    source = :birthday
    BIRTHDAY_TERMS.each do |keyword|
      @keywords << Keyword.new(keyword, 0, source, Date.today.to_s)
    end 
  end

end