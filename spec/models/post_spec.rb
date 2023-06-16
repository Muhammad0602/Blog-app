require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:author) { User.create(name: 'John Kane', photo: 'https:://photo.jpg', bio: 'I have no idea') }
  subject { Post.new(author:, title: 'This World is fake', text: 'This is a post') }

  describe 'validations' do
    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'title should have less than 250 characters' do
      subject.title = 'de' * 200
      expect(subject).to_not be_valid
    end

    it 'comment_counter should be an integer' do
      subject.comments_counter = 'ad'
      expect(subject).to_not be_valid
    end

    it 'comment counter should be greater than 0' do
      subject.comments_counter = -3
      expect(subject).to_not be_valid
    end

    it 'likes counter should be an integer' do
      subject.likes_counter = 'i am a string'
      expect(subject).to_not be_valid
    end

    it 'likes counter should be greater than 0' do
      subject.likes_counter = -312
      expect(subject).to_not be_valid
    end
  end

  describe '#update_post_counter' do
    it 'should update the post counter by 1' do
      expect { subject.save }.to change { author.posts_counter }.by(1)
    end
  end

  describe '#recent_comments' do
    it 'should return five recent comments' do
      author = User.create(name: 'John Kane', photo: 'https:://photo.jpg', bio: 'I have no idea')
      Comment.create(user: author, post: subject, text: 'comment', created_at: 12.days.ago)
      Comment.create(user: author, post: subject, text: 'comment', created_at: 10.days.ago)
      Comment.create(user: author, post: subject, text: 'comment', created_at: 9.days.ago)
      Comment.create(user: author, post: subject, text: 'comment', created_at: 7.days.ago)
      Comment.create(user: author, post: subject, text: 'comment', created_at: 5.days.ago)
      Comment.create(user: author, post: subject, text: 'comment', created_at: 2.days.ago)

      expect(subject.recent_comments.to_a.length).to eql(5)
    end
  end
end
