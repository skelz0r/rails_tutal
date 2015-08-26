class PostsController < ApplicationController

  before_action :redirect_unlogged_user, unless: :logged_in?, only: [:new, :create]

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post.id), flash: {success: "Post created !!!"}
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = @post.comments.build if logged_in?
  end

  def index
    @posts = Post.paginate(page: params[:page], :per_page => 5)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def redirect_unlogged_user
    redirect_to login_url, flash: {danger: "Please log in first !"}
  end

end
