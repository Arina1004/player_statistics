# frozen_string_literal: true

class MatchMetric::UpdateMatchMetric < BaseService
  include Dry::Monads::Do.for(:_call)

  def _call(match_metric:, params:)
    params = yield validate(Contract, params)
    match_metric = yield update_match_metric(match_metric, params)

    match_metric
  end

  private

  class Contract < Dry::Validation::Contract
    params do
      optional(:player).filled
      optional(:metric).filled
      optional(:match).filled
    end
  end

  def update_match_metric(match_metric, params)
    match_metric = MatchMetric.find(match_metric)
    match_metric.assign_attributes(
      params.slice(
        :player,
        :metric,
        :match
      )
    )
    if match_metric.save
      Success(match_metric)
    else
      Failure(match_metric.errors.to_h)
    end
  end
end
