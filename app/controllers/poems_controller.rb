class PoemsController < ApplicationController
  # skip_before_action :verify_authenticity_token, only :connect_to_twilio
  # before_action :connect_to_twilio, only: :show

  def show
    @poem = Poem.find(params[:id])
    capability = Twilio::Util::Capability.new(ENV["TWILIO_ACCOUNT_SID"],ENV["TWILIO_AUTH_TOKEN"])
    capability.allow_client_outgoing(ENV["TWILIO_APPLICATION_SID"])
    # binding.pry
    gon.token = capability.generate
  end

end
