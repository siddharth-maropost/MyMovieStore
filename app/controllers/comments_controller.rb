class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.movie_id = params[:movie_id]
    if @comment.save
      redirect_to movie_path(params[:movie_id]),notice: "comennt added succesfully"
    else
    end
  end
  def show
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
