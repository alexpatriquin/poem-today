class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    poem_path(current_user.user_poems.first.poem_id)
  end
end