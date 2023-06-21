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
end
