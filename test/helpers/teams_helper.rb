def create_team(name, description)
  post teams_path, params: { name: name, description: description }
end
