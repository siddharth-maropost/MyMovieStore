require 'api_constraints'
Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    #/api...Api::
    scope module: :v1, constraints: ApiConstraints.new(version: 1) do
      get '/search_movie_by_title', to: "movies#search_movie_by_title"
      get '/movies_all', to: "movies#movies_all"
      get '/movies_by_id', to: "movies#movies_by_id"

    end
    scope module: :v2, constraints: ApiConstraints.new(version: 2, default: true) do
      get '/search_movie_by_title', to: "movies#search_movie_by_title"
      get '/movies_all', to: "movies#movies_all"
      get '/movies_by_id', to: "movies#movies_by_id"


    end
  end



  match '/admin/movies' => 'movies#create', via: :post
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {sessions: 'users/sessions', omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :movies, :except => [:new, :delete,:edit,:update] do
    resources :comments

     collection do
        get "detail" , to: "movies#detail"
    end
  end
  root to: "movies#index"
  get '/api_key', to: "movies#api_key"
  get '/generate_api_key', to: "movies#generate_api_key"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
