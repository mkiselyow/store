class PrivateCabinateController < ApplicationController
  before_action :require_user
  before_action :user_resource

  def index
  end

  def history_of_orders
    @user_olders = @user.orders.order('id DESC').paginate(page: params[:page], per_page: 20)
  end

  def history_of_views
    @user_views = @user.user_views.order('id DESC').limit(10)
  end

  private

  def user_resource
    @user = User.find(current_user.id)
  end
end
