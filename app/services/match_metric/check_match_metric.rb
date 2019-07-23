
class MatchMetric::CheckMatchMetric < BaseService
  include Dry::Monads::Do.for(:_call)


  def _call(params:)
    params = yield validate(MatchMetricContract,  params)
    result= yield  check_match_metric(params)
  end

  private

  class MatchMetricContract < Dry::Validation::Contract
    params do
      required(:player_id).filled
      required(:metric_id).filled
    end
  end

  def check_match_metric(params)
    if !Player.where(id: params[:player_id]).blank?
      player = Player.find(params[:player_id])
      match_id = Match.joins(:teams).where(teams: {id: player.team_id}).last_five.pluck(:id)
      match_metric = MatchMetric.where(player_id: params[:player_id], metric_id: params[:metric_id], match_id: match_id).nil?
      Success(match_metric)

    else
      Failure(params.to_h)
    end

  end

end