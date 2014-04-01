Treasurebox2::Application.routes.draw do
  devise_for :users
  resources :posts
 
  root to: "posts#index"
  get "users/show/:id" => "users#show", as: "profile"
end
