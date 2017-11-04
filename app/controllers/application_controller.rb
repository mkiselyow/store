class ApplicationController < ActionController::Base
  include CurrentCart
  before_action :set_cart
  protect_from_forgery with: :exception
  before_action :banned?

  # devise email
  before_action :configure_permitted_parameters, if: :devise_controller?

  def banned?
    return unless current_user.present? && current_user.banned?

    sign_out current_user
    redirect_to root_path, notice: 'Вы добавлены в чёрный список сайта!'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email first_name last_name email number admin avatar username banned])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email first_name last_name email number admin avatar username banned])
    devise_parameter_sanitizer.permit(:login, keys: [:email])
  end

  # only logged in users
  # before_action :authenticate_user!

  private

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user == @user
  end

  def only_admin_access
    redirect_to(root_url) unless current_user && current_user.admin?
  end
end
