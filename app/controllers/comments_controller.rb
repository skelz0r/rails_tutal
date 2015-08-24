class CommentsController < ApplicationController

  before_action :redirect_unlogged_user, unless: :logged_in?, only: [:create]

  def create
    @comment =  current_user.comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@comment.post.id), flash: {success: "Comment created !!!"}
    else
      redirect_to post_path(@comment.post.id), flash: {danger: "Incorrect comment !"}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def redirect_unlogged_user
    redirect_to login_url, flash: {danger: "Please log in first !"}
  end

end
