require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'John Kane', photo: 'https:://photo.jpg', bio: 'I have no idea') }

  describe 'validations' do
    it 'the name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'the posts counter should be an interger' do
      subject.posts_counter = 'not number'
      expect(subject).to_not be_valid
    end

    it 'the posts counter should be greater than 0' do
      subject.posts_counter = -31
      expect(subject).to_not be_valid
    end
  end
  describe '#recent_posts' do
    it 'should return 3 recent posts' do
      Post.create(author: subject, title: 'The best', text: 'Just a post', created_at: 5.days.ago)
      Post.create(author: subject, title: 'The best', text: 'Just a post', created_at: 4.days.ago)
      post3 = Post.create(author: subject, title: 'The best', text: 'Just a post', created_at: 3.days.ago)
      post4 = Post.create(author: subject, title: 'The best', text: 'Just a post', created_at: 2.days.ago)
      post5 = Post.create(author: subject, title: 'The best', text: 'Just a post', created_at: 1.days.ago)

      expect(subject.recent_posts.to_a).to eql([post5, post4, post3])
    end
  end
end
