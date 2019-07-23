class Player < ActiveRecord::Base
  belongs_to :team, foreign_key: :team_id
  has_many :metrics, through: :match_metrics
  has_many :matches, through: :team

  def check_match_metric(metric_id)
    match_id = Match.joins(:teams).where(teams: { id: team.id }).last_five.pluck(:id)
    match_metric = !MatchMetric.where(player_id: id, metric_id: metric_id, match_id: match_id).nil?
  end

end