class CommentMailer < ApplicationMailer
  def comment_mail(user, movie, comment)
    @user = user
    @movie = movie
    @comment = comment

    mail(to: @user.email, subject: "Thanks for the comment on movie #{@movie.title}")
  end
end
