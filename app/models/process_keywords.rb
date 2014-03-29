module ProcessKeywords

  COMMON_WORDS = ["the", "a", "this", "what", "in", "very", "had", "he", "she", "it", "op-ed contributor", "our", "are", "out", "of", "an", "often", "period", "and"]
  
  def extract_keywords
    self.uniq.join(' ').downcase.gsub(/’s|[^a-z\s]/,' ').split.delete_if { |w| COMMON_WORDS.include?(w) }
  end

  # def score_keywords 
  # end

  def match_keywords
    self.each do |keyword|
      keyword_matches = Poem.where("title ILIKE :keyword", {keyword: "% #{keyword} %"}).pluck(:id)
    all_matches << keyword_matches if !keyword_matches.empty?
  end

end