class CommentsController < ApplicationController
before_action :set_article

def create
  @comment = @article.comments.build(comment_params)
  @comment.user = current_user
  if @comment.persisted?
    flash[:notice] = "Comment has been created."
  else
    flash[:alert] = "Comment has not been created."
  end
  redirect_to articles_path(@article)
end


private
  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_article
    @article = Article.find(params[:article_id])
  end

end
