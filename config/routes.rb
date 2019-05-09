Rails.application.routes.draw do

  resources :cards
  devise_for :users

  root to: "boards#index"

  resources :boards, except: :show do

    resources :cards, except: :destroy

  end

end
