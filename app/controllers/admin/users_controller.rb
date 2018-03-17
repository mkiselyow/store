class Admin::UsersController < AdminsController
  before_action :user_resource, only: %i[banned_user change_permission destroy make_admin make_moderator bust_user]

  def index
    @users = User.order(:id).page(params[:page])
  end

  def banned_user
    @user.update(banned: !@user.banned)
    redirect_back(fallback_location: admin_root_path,
                  notice: "Пользователь #{@user.full_name} был #{@user.banned ? 'заблокирован' : 'разблокирован'}")
  end

  def bust_user
    @user.user!
    redirect_back(fallback_location: admin_root_path, notice: 'Статус пользователя был изменён')
  end

  def make_moderator
    @user.moderator!
    redirect_back(fallback_location: admin_root_path, notice: 'Статус пользователя был изменён')
  end

  def make_admin
    @user.admin!
    redirect_back(fallback_location: admin_root_path, notice: 'Статус пользователя был изменён')
  end

  def destroy
    @user.destroy!
  end

  def user_resource
    @user = User.find(params[:id])
  end
end
