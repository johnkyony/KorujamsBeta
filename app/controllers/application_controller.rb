class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   skip_before_action :verify_authenticity_token
   
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
  # the routing after the login of different 
  def after_sign_in_path_for(resource)
   if resource.user?
    projects_path
   else
    if resource.developer?
      developers_path
    else
     if resource.admin?
       admins_path
     else
      landing_pages_path
     end
    end
   end
  end

end
