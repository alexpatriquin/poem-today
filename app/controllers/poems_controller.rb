class PoemsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :voice
  after_filter :set_header, only: :voice
  include Webhookable

  def show
    @poem = Poem.find(params[:id])
    capability = Twilio::Util::Capability.new(ENV["TWILIO_ACCOUNT_SID"],ENV["TWILIO_AUTH_TOKEN"])
    begin
      capability.allow_client_outgoing(ENV["TWILIO_APPLICATION_SID"])
      gon.token = capability.generate
    rescue
    end
  end

  def voice
    response = Twilio::TwiML::Response.new do |r|
      r.Say "#{params[:voice_title]}", :voice => 'man'
      r.Say "by #{params[:voice_poet]}"
      r.Say "#{params[:voice_content]}"
    end

    render_twiml response
  end

  # private 
  # def connect_to_twilio

  # end

end