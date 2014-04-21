class Ephemeral

  def create_ephemeral_poem(keywords)
    @keywords = keywords
    @parts_of_speech = {}
    call_wordnik_api
    organize_sentence
  end

  def call_wordnik_api
    @keywords.each do |keyword|
      limit = 1
      uri = "http://api.wordnik.com/v4/word.json/#{keyword}/definitions?word=#{keyword}&limit=#{limit}&api_key=#{ENV["WORDNIK_API_KEY"]}"
      parsed_uri = URI.parse(uri)
      response = Net::HTTP.get_response(parsed_uri)
      @parts_of_speech[keyword] = JSON.parse(response.body).pop["partOfSpeech"]
    end
  end

  def organize_sentence
    binding.pry
  end

end