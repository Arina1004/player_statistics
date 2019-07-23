# frozen_string_literal: true

class Player < ActiveRecord::Base
  belongs_to :team
  has_many :metrics, through: :match_metrics
  has_many :matches, through: :team

  validates :name, presence: true
  validates :team, presence: true

  def check_match_metric(metric)
    match_id = Match.joins(:teams).where(teams: { id: team.id }).last_five.pluck(:id)
    MatchMetric.where(player_id: id, metric_id: metric.id, match_id: match_id).any?
  rescue StandardError => e
    e
  end
end
