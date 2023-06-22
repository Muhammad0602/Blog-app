class LikesController < ApplicationController
    def new
        @like = Like.new
    end

    def create
        @like = Like.new(user_id: current_user.id, post_id: params[:post_id])

        if @like.save
            flash[:notice] = 'Your like was saved successfully'
            redirect_to user_posts_path(params[:user_id])
        else
            flash[:alert] = 'Something went wrong, please try again.'
        end
    end
end