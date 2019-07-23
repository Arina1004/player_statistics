# frozen_string_literal: true

FactoryBot.define do
  factory :player_new, class: Player do
  end

  factory :player, class: Player do
    name { Faker::Name.first_name }
    team_id { association(:team) }
  end

  factory :valid_top_five_players_params, class: OpenStruct do
    team_id { association(:team) || nil }
    metric_id { association(:metric) }
  end

  factory :valid_top_five_players_without_team_params, class: OpenStruct do
    metric_id { association(:metric) }
  end
end
