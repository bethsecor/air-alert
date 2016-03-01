Rails.application.routes.draw do
  root 'welcome#show'
  get '/auth/twitter/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '/airquality', to: 'air_quality#show'
end
