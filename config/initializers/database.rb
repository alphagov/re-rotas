require "English"

if ENV["RAILS_ENV"] == "production" && !$PROGRAM_NAME.match(/rake/)
  creds = CF::App::Credentials.find_by_service_name("rotas-db")

  # BODGE
  ENV["DB_HOST"]     = creds["hostname"]
  ENV["DB_PORT"]     = creds["port"].to_s
  ENV["DB_USER"]     = creds["username"]
  ENV["DB_PASSWORD"] = creds["password"]
end
