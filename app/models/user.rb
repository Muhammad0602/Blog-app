class User < ApplicationRecord
    validates :name, presence: true
    validates :posts_counter, numericality: {only_integer: true, grater_than_or_equal_to: 0}
    
  has_many :comments
  has_many :posts, foreign_key: :author_id
  has_many :likes

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
