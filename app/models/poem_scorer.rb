class PoemScorer

  def score_results
    RESULTS.each do |result|
      score_by_source(result)
      score_by_match_type(result)
    end
  end


  def score_by_source(result)

  end

  def score_by_match_type(result)

  end

end
