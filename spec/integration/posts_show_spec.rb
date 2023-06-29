require 'rails_helper'

RSpec.describe 'Posts Show', type: :system do
  describe 'Post show page' do
    let(:user) { User.create(name: 'Tango', photo: 'http://myphoto') }
    let(:first_post) { Post.create(author: user, title: 'blablabla', text: 'blablabla') }
    let(:second_post) { Post.create(author: user, title: 'dewdew', text: 'dewdewdew') }
    let(:comment) { Comment.create(user:, post: first_post, text: 'Nice one') }
    let(:like) { Like.create(user:, post: first_post) }
    before(:each) do
      comment.save
      like.update_like_counter
    end

    it 'shows the post info' do
      visit user_post_path(user_id: user.id, id: first_post.id)
      # I can see the post's title.
      expect(page).to have_content(first_post.title)
      # I can see who wrote the post.
      expect(page).to have_content(first_post.author.name)
      # I can see how many comments it has.
      expect(page).to have_css('p', text: "Comments: #{first_post.comments_counter}")
      # I can see how many likes it has.
      expect(page).to have_css('p', text: "Likes: #{first_post.likes_counter}")
      # I can see the post body.
      expect(page).to have_content(first_post.text)
      # I can see the username of each commentor.
      first_post.comments.each do |cm|
        expect(page).to have_content(cm.user.name)
        # I can see the comment each commentor left.
        expect(page).to have_content(cm.text)
      end
    end
  end
end
