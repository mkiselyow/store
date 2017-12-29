class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def new
    @user = User.new
  end

  def show
    @user_views = @user.user_views.last_six_views
    @user_olders = @user.orders.order('created_at DESC').limit(5)
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_url, notice: 'Вы успешно создали личный кабинет.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Информация обновлена.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if !@user.admin?
      @user.destroy
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'Пользователь был удален.' }
        format.json { head :no_content }
      end
    else
      redirect_to users_url
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :number, :avatar, :username, :banned)
  end
end
