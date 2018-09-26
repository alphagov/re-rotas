module Rotas::Errors
  class AuthorisationError < Exception
    def self.message
      'Authorisation error, are you using a GDS Google account?'
    end
  end
end
