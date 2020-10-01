module Rotas::Errors
  class AuthorisationError < Exception # rubocop:disable Lint/InheritException
    def self.message
      "Authorisation error, are you using a GDS Google account?"
    end
  end
end
