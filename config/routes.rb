Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root "pages#home"
  get "org-map", controller: :pages, action: :org_map, as: :org_map
  get "version", controller: :version, action: :version, as: :version, defaults: { format: "txt" }

  resources :org_units, only: %i[index show], path: "/org-units"

  resources :services, only: %i[index show new create edit update]

  resources :teams, only: %i[index show new create edit update]
  get "teams/:id/conflicts",
    as: "team_conflicts",
    controller: :teams,
    action: :conflicts

  resources :icalendars, only: %i[show], id: /.*/
  resources :calendars, only: %i[index show new create]
  resources :manual_calendars, only: %i[] do
    resources :events,
              only: %i[index new create edit update destroy],
              controller: :manual_calendar_events
  end
  resources :annual_leave_events, only: %i[index new create edit update destroy]

  resources :users, only: %i[show], id: /[^\/]*/
  get "users/:id/contact-info",
      id: /[^\/]*/,
      controller: :users,
      action: :contact_information,
      as: :user_contact_information

  resource :session, only: %i[new create destroy]
  get "session/callback",
      controller: :sessions,
      action: :callback,
      as: "callback_session"

  get "calendars/:id/edit",
      id: /pagerduty:.*/,
      controller: :pager_duty_calendars,
      action: :edit,
      as: "edit_pager_duty_calendar"

  patch "calendars/:id",
        id: /pagerduty:.*/,
        controller: :pager_duty_calendars,
        action: :update,
        as: "pager_duty_calendar"

  if %w[test development].include? Rails.env
    post "test_session_create", to: "test_session#create", as: :test_session_create
  end
end
