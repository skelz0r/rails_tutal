class PostsController < ApplicationController

  before_action :redirect_unlogged_user, unless: :logged_in?, only: [:new, :create]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_url, flash: {success: "Post created !!!"}
    else
      render 'new'
    end
  end

  def index
    @posts = Post.all
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def redirect_unlogged_user
    redirect_to login_url, flash: {danger: "Please log in first !"}
  end

end
