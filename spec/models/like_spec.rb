require 'rails_helper'

RSpec.describe Like, type: :model do
    let(:author) { User.create(name: 'John Kane', photo: 'https:://photo.jpg', bio: 'I have no idea') }
    let(:post) { Post.create(author: author, title: 'The best', text: 'Just a post') }
    subject { Like.new(user: author, post: post) }

    describe '#update_like_counter' do
        it 'increases the like counter by 1' do
           expect { subject.save }.to change {post.likes_counter}.by(1)
        end
    end
end