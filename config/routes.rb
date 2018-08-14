Rails.application.routes.draw do
  root 'pages#home'

  resources :teams, only: %i( index show new create edit update )
  get 'team/:id/conflicts',
    as: 'team_conflicts',
    controller: :teams,
    action: :conflicts

  resources :calendars, only: %i( index show new create)
  resources :manual_calendars, only: %i() do
    resources :events,
              only: %i( index new create edit update destroy ),
              controller: :manual_calendar_events
  end
  resources :annual_leave_events, only: %i( index new create edit update destroy )

  resources :users, only: %i( show ), id: /.*/

  resource :session, only: %i( new create destroy )
  get 'session/callback',
      controller: :sessions,
      action: :callback,
      as: 'callback_session'
end
