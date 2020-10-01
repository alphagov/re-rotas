class CreateJoinTableServiceTeam < ActiveRecord::Migration[6.0]
  def change
    create_join_table :services, :teams do |t|
      t.index %i[service_id team_id]
      t.index %i[team_id service_id]
    end
  end
end
