Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  
  get "/users/", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:id/posts", to: "posts#index"
  get '/users/:id/posts/new', to: 'posts#new', as: 'new_post' # new
  get "/users/:user_id/posts/:post_id", to: "posts#show"
  get '/users/:user_id/posts/:post_id', to: 'comments#new', as: 'new_comment' # new
  get '/users/:user_id/posts/:post_id/new_like', to: 'likes#new', as: 'new_like' # new
  get '/users/:user_id/posts/:post_id/destroy', to: 'posts#destroy', as: 'destroy_post' # destroy
  get '/users/:user_id/posts/:post_id/destroy_comment', to: 'comments#destroy', as: 'destroy_comment' # destroy

  post '/users/:id/posts/new', to: 'posts#create' # create
  post '/users/:user_id/posts/:post_id', to: 'comments#create' # create
  post '/users/:user_id/posts/:post_id/new_like', to: 'likes#create'
  post '/users/:user_id/posts/:post_id/destroy', to: 'posts#destroy' # destroy
  post '/users/:user_id/posts/:post_id/destroy_comment', to: 'comments#destroy' # destroy

  root to: "users#index"
end
