class PoemsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :voice
  after_filter :set_header, only: :voice
  include Webhookable

  def show
    @poem = Poem.find(params[:id])
    capability = Twilio::Util::Capability.new(ENV["TWILIO_ACCOUNT_SID"],ENV["TWILIO_AUTH_TOKEN"])
    capability.allow_client_outgoing(ENV["TWILIO_APPLICATION_SID"])
    # @token = capability.generate
    #why does this break production???
    #breaks even when @token isn't referenced in views or js...
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
    poem_kw = []
    poem_kw << Keyword.new(clicked_word,0,:from_poem,:user)
    results = KeywordSearch.new(poem_kw).match_keywords_to_poems
    results.delete_if { |result| result[:poem_id] == params[:from_poem].to_i }
    if results.empty?
      redirect_to authenticated_root_path, notice: "Perhaps another."
    else
      if session[:ephemeral_poem].nil?
        session[:ephemeral_poem] = []
      end
      session[:ephemeral_poem] << clicked_word
      session[:ephemeral_poem].uniq
      redirect_to poem_path(results.first[:poem_id]), notice: "Another poem with the word \"#{clicked_word}\"."
    end
  end

  def ephemeral
    if session[:ephemeral_poem] && session[:ephemeral_poem].count < 5
      flash[:notice] = "You do not have enough words for an ephemeral poem yet."
      redirect_to authenticated_root_path
    else
      @poem_title = session[:ephemeral_poem].first.titleize
      @poem = Ephemeral.new.create_ephemeral_poem(session[:ephemeral_poem])
      session[:ephemeral_poem] = []
    end
  end

end