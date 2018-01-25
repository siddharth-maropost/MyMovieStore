class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.movie_id = params[:movie_id]
    @movie = Movie.find(params[:movie_id])
    if @comment.save
      Thread.new{
        debugger
        CommentMailer.comment_mail(current_user, @movie, @comment).deliver_now
      }
      redirect_to movie_path(params[:movie_id]),notice: "comennt added succesfully"
    else
      redirect_to movie_path(params[:movie_id]),alert: "comment cannot be empty !"
    end
  end
  def show
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
