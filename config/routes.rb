Rails.application.routes.draw do
  root to: 'heros#index'
  match '/auth/:provider/callback', to: 'sessions#create', via: :all
  delete '/logout', to: 'sessions#destroy', as: :logout
end
