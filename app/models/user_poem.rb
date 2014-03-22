class UserPoem

  def initialize(user)
    @user = user    
  end

  def match_poem
    user_forecast_keywords.each do |keyword| 
      if !Poem.where("title LIKE :keyword", {keyword: "%#{keyword}%"}).empty?
        break Poem.where("title LIKE :keyword", {keyword: "%#{keyword}%"})
      else
        break Poem.find(rand(1..Poem.count))
      end
    end
  end

  def user_forecast_keywords
    Forecast.new.get_forecast_keywords(@user)
  end
end



# To Do
# match keywords to poem first line
# check to make sure poem has not been sent before (user_poem < AR DB)
# there must be a better way to search a table and return a result in an if statement

# put language into a module
# common words and synonyms
# https://github.com/roja/words
# https://github.com/doches/rwordnet
# https://github.com/yohasebe/engtagger