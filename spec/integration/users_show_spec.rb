require 'rails_helper'

RSpec.describe 'Users show', type: :system do
describe 'users show' do
    let(:user) { User.new(name: 'Tango', photo: 'http://myphoto') }
    let(:post) { Post.new(author: user, title: 'blablabla', text: 'blablabla') }

    before(:each) do
      user.save
      post.save
    end

    it "shows the user's profile picture." do
      visit user_path(user.id)
      expect(page).to have_css("img[src*='#{user.photo}']")
    end

    # I can see the user's username.
    it "shows the user's username." do
      visit user_path(user.id)
      expect(page).to have_content(user.name)
    end

    it 'shows the number of posts the user has written.' do
      visit user_path(user.id)
      expect(page).to have_content("Number of posts: #{user.posts.count}")
    end

    it "shows the user's bio." do
      visit user_path(user.id)
      expect(page).to have_content(user.bio)
    end

    # I can see the user's first 3 posts.
    it "shows the user's first 3 posts." do
      visit user_path(user.id)
      user.recent_posts.each do |post|
        expect(page).to have_content(post.title)
      end
    end
    # I can see a button that lets me view all of a user's posts.
    it "shows a button that lets me view all of a user's posts." do
      visit user_path(user.id)
      expect(page).to have_button('Show All Posts')
    end
  end

  describe 'checks the links' do
    before(:each) do
      user = User.create(name: 'Tango', photo: 'http://myphoto')
      Post.create(author: user, title: 'blablabla', text: 'blablabla')
    end
    let(:user) { User.first }
    let(:post) { user.posts[0] }
    it 'the user is redirected to the correct url' do
      visit root_path

      click_link user.name
      expect(page).to have_current_path(user_path(user.id))
    end

    it "redirects me to post's show page When I click a user's post." do
      visit user_posts_path(user.id)

      click_link post.title
      expect(page).to have_current_path(user_post_path(user_id: user.id, id: post.id))
    end
    it "redirects me to the user's post's index page When I click to see all posts" do
      visit user_path(user.id)

      click_link 'Show All Posts'
      expect(page).to have_current_path(user_posts_path(user_id: user.id))
    end
  end
end