Rails.application.routes.draw do
  root to: "users#index"
  get "/users/", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:id/posts", to: "posts#index"
  get '/users/:id/posts/new', to: 'posts#new', as: 'new_post' # new
  get "/users/:user_id/posts/:post_id", to: "posts#show"
  get '/users/:user_id/posts/:post_id', to: 'comments#new', as: 'new_comment' # new
  get '/users/:user_id/posts/:post_id/new_like', to: 'likes#new', as: 'new_like' # new

  post '/users/:id/posts/new', to: 'posts#create' # create
  post '/users/:user_id/posts/:post_id', to: 'comments#create' # create
  post '/users/:user_id/posts/:post_id/new_like', to: 'likes#create'
end
