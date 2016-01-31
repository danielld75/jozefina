class ArticlesController < ApplicationController

  before_action :require_user, only: [:new, :create, :update, :destroy, :edit]
  before_action :take_article, only: [:show, :edit, :update, :destroy]
  before_action :last_articles, only: [:edit, :new, :create, :index, :show]
  layout 'blog'

  def index
    @articles = Article.all_articles
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      redirect_to @article, notice: "Artykuł został pomyślnie dodany"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Zaktualizowałaś artykuł"
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Artykuł został usunięty."
  end

  private
  def article_params
    params.require(:article).permit(:title, :text, :photo)
  end
  def take_article
    @article = Article.find(params[:id])
  end
  def last_articles
    @last_articles = Article.list_of_articles
  end
end
