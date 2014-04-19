class BirthdayPoem

  BIRTHDAY_TERMS = ["birthday", "birthdays", "birth", "birth & birthdays"]

  def initialize(user)
    @user = user
  end

  def build_collection
    @matches = []

    add_to_keyword_collection
    match_keywords_to_poems
    save_poems_to_results
    @matches
  end

  def add_to_keyword_collection
    @keywords = []
    source = :birthday
    BIRTHDAY_TERMS.each do |keyword|
      @keywords << Keyword.new(keyword, 0, source, Date.today.to_s)
    end 
  end

  def match_keywords_to_poems  
    @keywords.each do |keyword|
      keyword.poems << Poem.search_by_occasion(keyword.text).map    { |poem| { :id => poem.id, :match_type => :occasion }}
      keyword.poems << Poem.search_by_poet(keyword.text).map       { |poem| { :id => poem.id, :match_type => :poet       }}
      keyword.poems << Poem.search_by_subject(keyword.text).map    { |poem| { :id => poem.id, :match_type => :subject }}
      keyword.poems << Poem.search_by_title(keyword.text).map      { |poem| { :id => poem.id, :match_type => :title }}
      keyword.poems << Poem.search_by_first_line(keyword.text).map { |poem| { :id => poem.id, :match_type => :first_line }}
      keyword.poems << Poem.search_by_content(keyword.text).map    { |poem| { :id => poem.id, :match_type => :content }}
      keyword.poems.flatten!
    end
  end

  def save_poems_to_results
    @keywords.each do |keyword|
      keyword.poems.each do |poem|
        poem_hash                      = {}
        poem_hash[:poem_id]            = poem[:id]
        poem_hash[:match_type]         = poem[:match_type]        
        poem_hash[:keyword_text]       = keyword.text
        poem_hash[:keyword_frequency]  = keyword.frequency
        poem_hash[:keyword_source]     = keyword.source
        poem_hash[:keyword_source_id]  = keyword.source_id
        @matches << poem_hash
      end
    end
  end

end