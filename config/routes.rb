Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments, only: [:create, :destroy]
  end

  # root 'posts#index'
  # get "/posts/new" => "posts#new", as: :new_post
  # post "/posts" => "posts#create", as: :posts
  # get "/posts/:id" => "posts#show", as: :post
  # get "/posts" => "posts#index"
  # delete "/posts/:id" => "posts#destroy"
end
