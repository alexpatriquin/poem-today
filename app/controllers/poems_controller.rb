class PoemsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :voice
  after_filter :set_header, only: :voice
  include Webhookable

  def show
    @poem = Poem.find(params[:id])
    capability = Twilio::Util::Capability.new(ENV["TWILIO_ACCOUNT_SID"],ENV["TWILIO_AUTH_TOKEN"])
    capability.allow_client_outgoing(ENV["TWILIO_APPLICATION_SID"])
    @token = capability.generate

    if params[:keyword]
      @poem_keyword = params[:keyword] #from the daily email
    elsif ephemeral_session?
      @poem_keyword = session[:ephemeral_poem].values.last #from clicked_word
    else
      @poem_keyword = @poem.first_line.split.max_by(&:length).gsub(/’s|[^a-z\s]/,'')
    end

    @poem_image_url = image_url(@poem_keyword) 
  end

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "#{params[:voice_title]}", :voice => 'man'
      r.Say "by #{params[:voice_poet]}"
      r.Say "#{params[:voice_content]}"
    end
    render_twiml response
  end

  def search
    clicked_word = params[:clicked_word].downcase.gsub(/’s|[^a-z\s]/,'')
    from_poem_id = params[:from_poem].to_i
    poem_kw = []
    poem_kw << Keyword.new(clicked_word,0,from_poem_id,:user)
    results = KeywordSearch.new(poem_kw).match_keywords_to_poems
    results.delete_if { |result| result[:poem_id] == from_poem_id }
    if results.empty?
      redirect_to Poem.find(from_poem_id), notice: "No poems with the word \"#{clicked_word}\""
    else
      if session[:ephemeral_poem].nil?
        session[:ephemeral_poem] = {}
      end
      session[:ephemeral_poem][from_poem_id] = clicked_word
      if ephemeral_poem?
        redirect_to poem_path(results.first[:poem_id]), notice: %Q[You've created a new <a href="#{ephemeral_path}"> poem</a>.].html_safe
      else
        redirect_to poem_path(results.first[:poem_id])
      end
    end

  end

  def ephemeral
    if !ephemeral_poem?
      flash[:notice] = "This correlation is well established for ephemeral species."
      redirect_to authenticated_root_path
    else
      markov = MarkyMarkov::TemporaryDictionary.new
      session[:ephemeral_poem].keys.each { |poem_id| markov.parse_string(Poem.find(poem_id).content) }
      @poem_title = session[:ephemeral_poem].values[-4..-1].join(' ')
      @poem_content = []
      3.times { @poem_content << markov.generate_1_sentences }
      @poem_keyword = @poem_content.first.split.max_by(&:length).gsub(/’s|[^a-z\s]/,'')
      @poem_image_url = image_url(@poem_keyword)
      markov.clear!
      session[:ephemeral_poem] = {}
    end
  end

  def image_url(keyword)
    FlickRaw.api_key = ENV["FLICKR_API_KEY"]
    FlickRaw.shared_secret = ENV["FLICKR_API_SECRET"]
    flickr_photo = flickr.photos.search("text"=>"#{keyword}", "sort"=> "relevance", "per_page" => 1).first
    @poem_image_url = "http://farm#{flickr_photo.farm}.staticflickr.com/#{flickr_photo.server}/#{flickr_photo.id}_#{flickr_photo.secret}.jpg"
  end

end