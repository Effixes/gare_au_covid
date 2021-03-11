Rails.application.routes.draw do
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # Route for design css

  resources :games, only: [:create, :show] do
    resources :players, only: [:create]

    member do
      # /games/:id/start
      patch :start
      patch :draw
      patch :end_turn
    end

    resources :played_cards, only: [:create]

    # /games/top
    # collection do
    #   get :top
    # end
  end

  get "components", to: 'pages#components'

end
