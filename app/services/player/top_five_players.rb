
class Player::TopFivePlayers < BaseService
  include Dry::Monads::Do.for(:_call)


  def _call(params:)
    params = yield validate(MatchMetricContract,  params)
    metric= yield  find_top_five_players(params)
    players = metric.map{ |c|  {player_id: c.player.id , sum: c.sum} }
    players

  end

  private

  class MatchMetricContract < Dry::Validation::Contract
    params do
      optional(:team_id).filled
      required(:metric_id).filled
    end
  end

  def find_top_five_players(params)
      match_metric = MatchMetric.joins(:player).select('player_id, count(*) as sum').where(metric_id: params[:metric_id]).top_five
      match_metric = match_metric.where(players: { team_id: params[:team_id]}) if params[:team_id].present?
      Success(match_metric)
  end

end