Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'home' ,to: 'static_pages#home', as:'home'
  get 'heros', to: 'heros#index', as: 'heros'
  get 'meta', to: 'users#meta', as: 'meta'
  get 'your_stats', to: 'users#show', as: 'your_stats'
  match '/auth/:provider/callback', to: 'sessions#create', via: :all
  delete '/logout', to: 'sessions#destroy', as: :logout
end
