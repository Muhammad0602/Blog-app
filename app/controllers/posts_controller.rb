class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)
  end

  def show
    @post = Post.find(params[:id])
    # @user = User.find(params[:user_id])
    # @post = Post.where(author_id: @user.id).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    # @user = User.find(params[:user_id])
    # @post = Post.new(author_id: @user.id, **post_params)

    @post = Post.new(author_id: current_user.id, **post_params)

    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_posts_path(params[:user_id])
    else
      flash[:alert] = 'Something went wrong. Please try again!'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
