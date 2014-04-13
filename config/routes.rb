Treasurebox2::Application.routes.draw do
  # get "categories/index"
  # get "categories/new"
  # get "categories/create"
  devise_for :users
  resources :posts, :categories
 
  root to: "posts#index"
  get "users/show/:id" => "users#show", as: "profile"
end
