# frozen_string_literal: true

class Player::TopFivePlayers < BaseService
  include Dry::Monads::Do.for(:_call)

  def _call(params:)
    params = yield validate(Contract, params)
    metric = yield find_top_five_players(params)
    players = metric.map { |c| { player: c.player, sum: c.sum } }
    players
  end

  private

  class Contract < Dry::Validation::Contract
    params do
      optional(:team).filled
      required(:metric).filled
    end
  end

  def find_top_five_players(params)
    match_metric = MatchMetric.joins(:player).select('player_id, count(*) as sum').where(metric_id: params[:metric].id).top_five
    match_metric = match_metric.where(players: { team_id: params[:team].id }) if params[:team].present?
    Success(match_metric)
  end
end
