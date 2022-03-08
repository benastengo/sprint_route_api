Rails.application.routes.draw do
  get "/users" => "users#index"
  get "/users/:id" => "users#show"
  post "/users" => "users#create"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/customers" => "customers#index"
  get "/customers/:id" => "customers#show"
  post "/customers" => "customers#create"
  
  post "/sessions" => "sessions#create"
end
