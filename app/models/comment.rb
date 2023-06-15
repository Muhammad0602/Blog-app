class Comment < ApplicationRecord
    belongs_to :user, foreign_key: :user_id
    belongs_to :post

    after_save :update_comment_counter

    def update_comment_counter
        post.increment!(:comments_counter)
    end
end
