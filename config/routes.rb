Rails.application.routes.draw do

  root to: "boards#index"

  devise_for :users

  resources :boards do
    resources :cards, only: [:new, :create] do
    end
  end

  resources :cards, only: [:show, :edit, :update] do
    patch :status, on: :member

    resources :comments
  end

end
