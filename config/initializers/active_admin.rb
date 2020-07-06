class SessionAuthAdapter < ActiveAdmin::AuthorizationAdapter
  def authorized?(_, _ = nil)
    Rotas::Authorisation.is_admin?(user)
  end
end

ActiveAdmin.setup do |config|
  config.site_title = "Rotas"
  config.site_title_link = "/"

  config.authentication_method = :maybe_redirect_if_not_signed_in
  config.authorization_adapter = SessionAuthAdapter
  config.current_user_method = :current_user

  config.logout_link_path = :session_path
  config.logout_link_method = :delete

  config.comments = false
  config.batch_actions = true

  config.filter_attributes = [:encrypted_password, :password, :password_confirmation]
  config.localize_format = :long
end

ActiveAdmin::ResourceController.class_eval do
  def find_resource
    finder = resource_class.is_a?(FriendlyId) ? :slug : :id
    scoped_collection.find_by(finder => params[:id])
  end
end
