class CreatePlayer < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name, null: false
      t.integer :team_id, null: false
      t.timestamps
    end
    add_index :players, :team_id
  end
end
