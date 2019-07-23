class MatchMetric < ActiveRecord::Base
  belongs_to :player,  foreign_key: :player_id
  belongs_to :match,  foreign_key: :match_id
  belongs_to :metric,  foreign_key: :metric_id
end