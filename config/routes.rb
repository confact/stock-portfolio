Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :accounts, only: [:new, :create]

  root to: "accounts#new"
end
