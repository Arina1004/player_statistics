
class MatchMetric::CreateMatchMetric < BaseService
  include Dry::Monads::Do.for(:_call)

  def _call(params:)
    params = yield validate(MatchMetricContract,  params)
    match_metric = yield create_match_metric(params)

    Success(match_metric)
  end

  private

  class MatchMetricContract < Dry::Validation::Contract
    params do
      required(:player_id).filled
      required(:metric_id).filled
      required(:match_id).filled
    end
  end

  def create_match_metric(params)
    match_metric = MatchMetric.new()
    match_metric.assign_attributes(
      params.slice(
        :player_id,
        :metric_id,
        :match_id
      )
    )
    if match_metric.save
      Success(match_metric)
    else
      Failure(match_metric.errors.to_h)
    end
  end


end