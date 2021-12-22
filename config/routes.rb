Rails.application.routes.draw do
  root to: "users#index"
  get "/users/", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:id/posts", to: "posts#index"
  get '/users/:id/posts/new', to: 'posts#new', as: 'new_post' # new
  get "/users/:user_id/posts/:post_id", to: "posts#show"

  post '/users/:id/posts/new', to: 'posts#create' # create
  get '/users/:user_id/posts/:post_id', to: 'comments#new', as: 'new_comment' # new
  post '/users/:user_id/posts/:post_id', to: 'comments#create' # create

end
