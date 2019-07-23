class Player < ActiveRecord::Base
  belongs_to :team, foreign_key: :team_id
  has_many :metrics, through: :match_metrics
  has_many :matches, through: :team
end