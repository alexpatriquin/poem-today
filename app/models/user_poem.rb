class UserPoem

  def initialize(user)
    @user = user    
  end

  def match_poem
    Poem.find(rand(1..Poem.count))
  end
end


