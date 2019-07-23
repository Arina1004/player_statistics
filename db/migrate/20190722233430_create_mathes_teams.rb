class CreateMathesTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :matches_teams do |t|
      t.integer :match_id, null: false
      t.integer :team_id, null: false
    end
    add_index :matches_teams, [:match_id, :team_id], unique: true
  end
end
