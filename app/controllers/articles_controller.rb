class ArticlesController < ApplicationController
  def index
  end

  def new
    @article = Article.new
  end
end
