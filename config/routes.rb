Rails.application.routes.draw do
  root 'welcome#show'
  get '/auth/twitter/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/airquality', to: 'air_quality#show'
  get '/alerts', to: 'alerts#index'
  get '/legislation', to: 'legislation#show'

  resources :outdoor_alerts, only: [:new, :create, :destroy, :edit, :update]
  resources :indoor_alerts, only: [:new, :create, :destroy, :edit, :update]

  get '/bills/:bill_id', to: 'bills#show'
end
