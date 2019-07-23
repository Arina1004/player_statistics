class CreateMatchMetric < ActiveRecord::Migration[5.2]
  def change
    create_table :match_metrics do |t|
      t.integer :player_id, null: false
      t.integer :metric_id, null: false
      t.integer :match_id, null: false

    end
    add_index :match_metrics, [:match_id ,:player_id,:metric_id], unique: true
  end
end
