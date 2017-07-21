class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  #devise email
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :first_name, :last_name, :email, :number, :admin, :avatar, :username])
    devise_parameter_sanitizer.permit(:login, keys: [:email])
  end

  # only logged in users
  # before_action :authenticate_user!
end
