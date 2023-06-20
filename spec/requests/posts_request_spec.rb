require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before { get '/users/5/posts' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders correct template' do
      expect(response).to render_template(:index)
    end

    it 'the body returns a correct placeholder' do
      expect(response.body).to include('show the list of posts')
    end
  end

  describe 'GET /show' do
    before { get '/users/5/posts/2' }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a correct template' do
      expect(response).to render_template(:show)
    end

    it 'body return right placeholder' do
      expect(response.body).to include('show details about a specific post')
    end
  end
end
