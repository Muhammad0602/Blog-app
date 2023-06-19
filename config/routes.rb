Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
 
#  Writing routes using the regular method
  # get '/users' to: 'users#index'
  # get '/users/:id' to: 'users#show'
  # get '/users/:id/posts' to: 'posts#index'
  # get 'users/:id/posts/:id' to 'posts#show'

  # Writing routes using nested method
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show]
  end
end
