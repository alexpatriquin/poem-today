class Keyword
  attr_accessor :text, :frequency, :source, :poems

  KEYWORDS = []

  def initialize(text, frequency, source)
    @text = text
    @frequency = frequency
    @source = source
    @poems = []
  end
end