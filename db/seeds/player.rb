# frozen_string_literal: true

puts '--Player seeds begin --'
[1, 2, 3].each do |team|
  FactoryBot.create_list(:player, 10, team_id: team)
end
