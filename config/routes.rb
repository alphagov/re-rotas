Rails.application.routes.draw do
  root 'pages#home'

  resources :calendars, only: %i( index show )
  resources :teams, only: %i( index show new create )
end
