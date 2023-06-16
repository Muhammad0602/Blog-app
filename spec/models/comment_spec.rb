require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:author) { User.create(name: 'John Kane', photo: 'https:://photo.jpg', bio: 'I have no idea') }
  let(:post) { Post.create(author:, title: 'The best', text: 'Just a post') }
  subject { Comment.new(user: author, post:, text: 'A good one') }

  describe '#update_comment_counter' do
    it 'should update comment counter' do
      expect { subject.save }.to change { post.comments_counter }.by(1)
    end
  end
end
