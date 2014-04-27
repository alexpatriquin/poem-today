class PoemScorer

  def score_results(results)
    results.each do |result|
      result[:match_score] = 0
      score_by_keyword_source(result)
      score_by_match_type(result)
      score_by_frequency(result)
    end
  end

  def score_by_keyword_source(result)
    case result[:keyword_source]
    when :twitter
      result[:match_score] += 40
    when :news
      result[:match_score] += 30  
    when :forecast
      result[:match_score] += 20
    end
  end

  def score_by_match_type(result)
    case result[:match_type]
    when :occasion || :subject || :poet
      result[:match_score] += 100
    when :title
      result[:match_score] += 50
    when :first_line
      result[:match_score] += 30  
    when :content
      result[:match_score] += 10
    end
  end

  def score_by_frequency(result)
    #birthdays, name days and holidays have 0 freq => 100 points
    frequency_score = (1000 - result[:keyword_frequency]) / 10
    result[:match_score] += frequency_score
  end

end