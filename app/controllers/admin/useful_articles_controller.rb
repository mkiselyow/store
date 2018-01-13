class Admin::UsefulArticlesController < AdminsController
  before_action :article_resource, only: %i[edit update destroy]

  def index
    @useful_articles = UsefulArticle.all
  end

  def new
    @useful_article = UsefulArticle.new
  end

  def create
    @useful_article = UsefulArticle.create(articles_params)
    if @useful_article.save
      redirect_to admin_useful_articles_path, notice: 'Новая статья добавлена'
    else
      render :new
    end
  end

  def update
    if @useful_article.update(articles_params)
      redirect_to admin_useful_articles_path, notice: 'Статья была успешно обновлена'
    else
      render :edit
    end
  end

  def destroy
    @useful_article.destroy!
    redirect_to admin_useful_articles_path, notice: 'Статья удалена'
  end

  private

  def article_resource
    @useful_article = UsefulArticle.find(params[:id])
  end

  def articles_params
    params.require(:useful_article).permit(:title, :body, :preview, :user_id, :published, :category_post_id)
  end
end
