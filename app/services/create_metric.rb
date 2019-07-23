
class CreateMetric < BaseService
  include Dry::Monads::Do.for(:_call)

  def _call(params:)
    params = yield validate(MetricContract,  params)
    match_metricc = yield create_match_metric(params)

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
    match_metric
    review.assign_attributes(
      params.slice(
        :comment,
        :score
      ), without_protection: true
    )
    review.assign_attributes({ reviewer_id: params[:user_id] }, without_protection: true)
    if review.save
      Success(review)
    else
      Failure(review.errors.to_h)
    end
  end


end