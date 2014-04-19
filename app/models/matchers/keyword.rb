class Keyword
  attr_accessor :text, :frequency, :source, :source_id, :poems

  KEYWORDS = []

  def initialize(text, frequency, source)
    @text = text
    @frequency = frequency ||= 1001
    @source = source
    @poems = []
  end
end