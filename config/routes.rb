Rails.application.routes.draw do
  match '/admin/movies' => 'movies#create', via: :post
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :movies, :except => [:new, :delete,:edit,:update] do
    resources :comments

     collection do
        get "detail" , to: "movies#detail"
    end
  end
  root to: "movies#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
