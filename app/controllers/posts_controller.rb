class PostsController < ApplicationController
  # before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author_id: @user.id)

    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  end

  def show
    @post = Post.find(params[:id])
    # @user = User.find(params[:user_id])
    # @post = Post.where(author_id: @user.id).find(params[:id])
  end

  def new
    @post = Post.new
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.destroy
    @user.posts_counter -= 1
    @user.save
    redirect_to user_posts_path(@user)
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
