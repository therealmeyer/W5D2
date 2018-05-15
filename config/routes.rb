Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: [:destroy] do
    resources :posts, except: [:index] do
      resources :comments, only: [:new] do
        resources :comments, only: [:new, :create] 
      end
    end
  end

  resources :comments, only: [:create, :show]

  root to: 'subs#index'
end
