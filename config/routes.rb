Rails.application.routes.draw do

  resources :friendship_analyses
  resources :twitter_accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  get '/auth/:twitter/callback', to: 'sessions#create', as: 'callback'
  get '/auth/failure', to: 'sessions#error', as: 'failure'
  get '/profile', to: 'sessions#show', as: 'show'
  delete '/signout', to: 'sessions#destroy', as: 'signout'

end
