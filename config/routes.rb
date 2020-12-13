Rails.application.routes.draw do
  resources :users, only: [] do
    resources :appointments, only: [:create, :index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
