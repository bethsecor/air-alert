Rails.application.routes.draw do
  root 'welcome#show'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/airquality', to: 'air_quality#show'
end
