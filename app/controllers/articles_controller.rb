class ArticlesController < ApplicationController
before_action :set_article, only: [:show,:edit,:update,:destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    @article.save
    if @article.persisted?
      flash[:success] = "Article has been created"
      redirect_to articles_path
    else
      flash.now[:danger] = "Article has not been created"
      render :new
    end
  end

  def show
    @comment = @article.comments.build
    @comments = @article.comments
  end

  def edit
    if user_signed_in?
      unless @article.user === current_user
        flash_message = "Only the owner can edit the Article."
        flash[:alert] = flash_message
        render :show
      end
    else
      flash_message = "You need to sign in before continue."
      flash[:alert] = flash_message
      redirect_to new_user_session_path
    end

  end

  def update
    unless @article.user === current_user
      flash_message = "Only the owner can edit the Article."
      flash[:alert] = flash_message
      redirect_to root_path
    else
      if @article.update(article_params)
        flash[:success] = "Article has been updated"
        redirect_to article_path(@article)
      else
        flash.now[:danger] = "Article has not been updated"
        render :edit
      end
    end
  end

  def destroy
    unless @article.user === current_user
      flash_message = "You can not delete the Article."
      flash[:alert] = flash_message
      redirect_to @article
    else
      if @article.destroy
        flash[:success] = "Article has been deleted"
        redirect_to articles_path
      end
    end
  end

  protected
    def resource_not_found
      message = "The article you are looking for could not be found"
      flash[:danger] = message
      redirect_to root_path
    end

  private
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end
end
