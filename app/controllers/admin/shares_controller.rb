class Admin::SharesController < AdminsController
  before_action :share_resource, only: %i[edit update destroy]

  def index
    @shares = Share.order(:id).paginate(page: params[:page], per_page: 20)
  end

  def new
    @share = Share.new
  end

  def create
    @share = Share.create(share_params)
    if @share.save
      redirect_to admin_shares_path, notice: 'Новая статья добавлена'
    else
      render :new
    end
  end

  def update
    if @share.update(share_params)
      redirect_to admin_shares_path, notice: 'Статья была успешно обновлена'
    else
      render :edit
    end
  end

  def destroy
    @share.destroy!
    redirect_to admin_shares_path, notice: 'Статья удалена'
  end

  private

  def share_resource
    @share = Share.find(params[:id])
  end

  def share_params
    params.require(:share).permit(:title, :body, :poster, :user_id, :start_share, :end_share)
  end
end
