class AdminsController < ActionController::Base
  layout 'admin/application'

  before_action :require_admin

  private

  def require_admin
    redirect_to root_path unless current_user.try(:admin)
  end
end
