Rails.application.routes.draw do
  root to: "users#index" # Specifies the root for the app
  get "/users/", to: "users#index"
  get "/users/:id", to: "users#show"
  get "/users/:id/posts", to: "posts#index"
  get "/users/:id/posts/:id", to: "posts#show"
end
