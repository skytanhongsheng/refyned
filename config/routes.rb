Rails.application.routes.draw do
  devise_for :users
  root to: "curricula#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :curricula
  resources :lessons
  resources :cards, only: %i[new] do
    member do
      patch :attempt
      get :bookmark
    end
  end

  get ":mode/card/:id", to: 'cards#show', as: :card, mode: /learning|test/
  resources  :bookmarks, only: %i[index]
end
