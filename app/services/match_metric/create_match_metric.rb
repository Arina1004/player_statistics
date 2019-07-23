# frozen_string_literal: true

class MatchMetric::CreateMatchMetric < BaseService
  include Dry::Monads::Do.for(:_call)

  def _call(params:)
    params = yield validate(Contract, params)
    match_metric = yield create_match_metric(params)

    match_metric
  end

  private

  class Contract < Dry::Validation::Contract
    params do
      required(:player).filled
      required(:metric).filled
      required(:match).filled
    end
  end

  def create_match_metric(params)
    match_metric = MatchMetric.new
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
