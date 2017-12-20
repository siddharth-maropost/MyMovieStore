Rails.application.routes.draw do
  devise_for :users
  resources :movies do
    resources :comments

     collection do
        get "detail" , to: "movies#detail"
    end
  end
  root to: "home#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
