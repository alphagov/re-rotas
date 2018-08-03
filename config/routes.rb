Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pagerduty_calendars, only: %i( index show new create )
  resources :teams, only: %i( index show new create )
end
