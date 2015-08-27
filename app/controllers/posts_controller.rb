class PostsController < ApplicationController

  before_action :redirect_unlogged_user, unless: :logged_in?, only: [:new, :create]
  before_action :redirect_non_authorized_user, unless: :current_user_is_post_user?, only: :destroy

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

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      redirect_to root_url, flash: {success: "Post deleted"}
    else
      redirect_to root_url, flash: {danger: "Invalid action"}
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def redirect_unlogged_user
    redirect_to login_url, flash: {danger: "Please log in first !"}
  end

  def redirect_non_authorized_user
    redirect_to root_url, flash: {danger: "Invalid action!!"}
  end

  def current_user_is_post_user?
    Post.find(params[:id]).user == current_user
  end

end
