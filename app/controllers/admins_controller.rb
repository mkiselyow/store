class AdminsController < ActionController::Base
  layout 'admin/application'

  before_action :require_admin
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email first_name last_name email number admin avatar username banned])
  end

  private

  def require_admin
    redirect_to root_path unless current_user.try(:admin)
  end
end
