# frozen_string_literal: true

puts '--Match seeds begin --'
[[1, 2], [1, 2], [2, 3], [1, 3], [2, 3]].each do |team|
  FactoryBot.create_list(:match, 10, teams: Team.where(id: team))
end
