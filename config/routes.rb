Rails.application.routes.draw do
  root 'pages#home'
  delete 'pages#sign_out', as: 'sign_out', controller: :pages, action: :sign_out

  resources :calendars, only: %i( index show new create)
  resources :teams, only: %i( index show new create )
  resources :manual_calendars, only: %i() do
    resources :events,
              only: %i( index new create edit update destroy ),
              controller: :manual_calendar_events
  end
end
