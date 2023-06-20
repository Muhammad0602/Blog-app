require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    before { get '/users' }

    it 'return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renderes a correct template' do
      expect(response).to render_template(:index)
    end

    it ' the body returns the correct placeholder' do
      expect(response.body).to include('show a list of users')
    end
  end

  describe 'GET /show' do
    before { get '/users/5' }

    it 'return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders a correct template' do
      expect(response).to render_template(:show)
    end

    it 'the body returns a correct placeholder' do
      expect(response.body).to include('display details about a user')
    end
  end
end
