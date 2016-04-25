Rails.application.routes.draw do
  root 'games#index'

  resources :games
  resources :cells do
    member do
      post :sweep

    end
  end
end
