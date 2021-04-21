Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  #mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :streams
  resources :viewcounts
  get 'static_pages/home'
  get 'static_pages/profile'
  get '/users/render_chart', to: 'users#render_chart'
  get '/users/begin_viewcount_sample', to: 'users#begin_viewcount_sample'
  resources :users
  resources :posts
  resources :follows
  root 'welcome#index'

  get '/signup', to: 'users#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get '/search' => 'search#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
