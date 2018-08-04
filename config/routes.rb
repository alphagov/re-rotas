Rails.application.routes.draw do
  root 'pages#home'

  resources :pagerduty_calendars, only: %i( index show new create )
  resources :teams, only: %i( index show new create )
end
