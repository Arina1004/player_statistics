# frozen_string_literal: true

FactoryBot.define do
  factory :match_metric_new, class: MatchMetric do
    association :player, factory: :player
    association :match, factory: :match
    association :metric, factory: :metric
  end

  factory :match_metric, class: MatchMetric do
    player_id { association(:player) }
    match_id { association(:match) }
    metric_id { association(:metric) }
  end

  factory :valid_match_metric_params, class: OpenStruct do
    player_id { association(:player) }
    match_id { association(:match) }
    metric_id { association(:metric) }
  end

  factory :valid_check_match_metric_params, class: OpenStruct do
    player_id { association(:player) }
    metric_id { association(:metric) }
  end

end
