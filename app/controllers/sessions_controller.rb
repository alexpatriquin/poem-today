class SessionsController < Devise::SessionsController

def new
  super
  session[:ephemeral_poem] = {}
end

end