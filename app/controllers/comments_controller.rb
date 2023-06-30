class CommentsController < ApplicationController
  # before_action :authenticate_user!
  protect_from_forgery with: :exception, except: [:create]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def new
    @comment = Comment.new
  end

  def create
    if request.format.html?
      @comment = Comment.new(user_id: current_user.id, post_id: params[:post_id], **comment_params)

      if @comment.save
        flash[:notice] = 'Your comment was added successfully'
        redirect_to user_posts_path(params[:user_id])
      else
        flash[:alert] = 'Opps, something went wrong, try again!'
        render :new
      end
    else
      begin
        @user = User.find(params[:user_id])
        @post = Post.find(params[:post_id])
        @comment = Comment.new(user: @user, post: @post, **comment_params)
        if @comment.save
          render json: { message: 'Comment created successfully' }, status: 201
        else
          render json: @comment.errors, status: 401
        end
      rescue ActiveRecord::RecordNotFound
        render json: { message: 'Invalid post or user id' }, status: 404
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.post.comments_counter -= 1
    @comment.post.save
    @comment.destroy
    redirect_to user_posts_path(@comment.user.id)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
