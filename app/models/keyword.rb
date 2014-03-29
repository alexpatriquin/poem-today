class Keyword
  attr_accessor :keyword_text, :frequency, :sources, :poems

  KEYWORDS = []

  def initialize(keyword_text, frequency)
    @keyword_text = keyword_text
    @frequency = frequency
    @sources = []
    @poems = []
  end
end