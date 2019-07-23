
class MatchMetric::UpdateMatchMetric < BaseService
  include Dry::Monads::Do.for(:_call)

  def _call(match_metric_id:, params:)
    params = yield validate(MatchMetricContract,  params)
    match_metric = yield update_match_metric(match_metric_id, params)

    Success(match_metric)
  end

  private

  class MatchMetricContract < Dry::Validation::Contract
    params do
      optional(:player_id).filled
      optional(:metric_id).filled
      optional(:match_id).filled
    end
  end

  def update_match_metric(match_metric_id,params)
    if !match_metric_id.nil?
      match_metric = MatchMetric.find(match_metric_id)
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
end