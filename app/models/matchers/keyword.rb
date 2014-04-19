class Keyword
  attr_accessor :text, :frequency, :source, :source_id, :poems

  def initialize(text, frequency, source, source_id)
    @text = text
    @frequency = frequency ||= 1001
    @source = source
    @source_id = source_id
    @poems = []
  end
end