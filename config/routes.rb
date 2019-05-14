Rails.application.routes.draw do

  root to: "boards#index"

  devise_for :users

  resources :boards do

    resources :cards, except: :destroy

  end

  resources :card, only: [] do
    resources :comments
  end

end
