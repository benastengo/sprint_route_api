Rails.application.routes.draw do
  get "/users" => "users#index"
  get "/users/:id" => "users#show"
  post "/users" => "users#create"
  patch "/users/:id" => "users#update"
  delete "/users/:id" => "users#destroy"

  get "/customers" => "customers#index"
  get "/customers/:id" => "customers#show"
  post "/customers" => "customers#create"

  get "/orders" => "orders#index"
  post "/orders" => "orders#create"
  patch "/orders/assignment" => "orders#assignment"
  patch "/orders/:id" => "orders#update"
  delete "/orders/:id" => "orders#destroy"
  
  post "/sessions" => "sessions#create"
end
