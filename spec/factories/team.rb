# frozen_string_literal: true

FactoryBot.define do
  factory :team_new, class: Team do
  end

  factory :team, class: Team do
    name { Faker::Name.first_name }
  end
end
