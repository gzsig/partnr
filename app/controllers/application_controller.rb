class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :require_admin!, unless: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :bio, :phone_number, :CPF, :occupation, :address])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:bio, :phone_number, :occupation, :address])
  end

private

  def require_admin!
    unless current_user && current_user.adm?
      flash[:notice] = 'You must be admin make this action'
      redirect_to root_path
    end
  end
end
