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
      result[:match_score] += 1
    end
  end

  def score_by_frequency(result)
    #birthdays, name days and holidays have 0 freq => 100 points
    frequency_score = (1000 - result[:keyword_frequency]) / 10
    result[:match_score] += frequency_score
  end

end






# frequency stats
# 2000 - 2012, total count / occurence per 1M words
# google 542
# is 78020
# cats 190
# him 12343
# coke 15
# brother 655
# lunch 356
# road 1155
# traveled 128
# work 6188
# sex 928
# directions 132
# us 10069          100th most common word in English
# few 4039          186th
# receive 651       500th #noisy
# stuff 1375        1000th
# limited 539       2000th
# till 342          5000th

# http://www.englishclub.com/vocabulary/common-words-5000.htm#.UzcdR61dXZU