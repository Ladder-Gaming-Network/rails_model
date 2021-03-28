Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/profile'
  get '/profile/follow', to: 'static_pages#follow'
  get '/profile/unfollow', to: 'static_pages#unfollow'
  resources :users
  resources :posts
  resources :follows
  root 'welcome#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
