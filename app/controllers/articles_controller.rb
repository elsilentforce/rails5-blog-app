class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    if @article.persisted?
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash[:warning] = "Article has not been created"
      render :new
    end
  end

  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
end
