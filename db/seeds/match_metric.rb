# frozen_string_literal: true

puts '--Match_metric seeds begin --'
[1, 2, 3, 4, 5].each do |player|
  FactoryBot.create(:match_metric, player_id: player, metric_id: rand(6), match_id: rand(10))
end
