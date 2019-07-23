# frozen_string_literal: true

FactoryBot.define do
  factory :match_new, class: Match do
  end

  factory :match, class: Match do
    name { Faker::Name.first_name }
    date { Faker::Time.between(DateTime.now - 1.weeks, DateTime.now + 1.weeks) }
    teams {[association(:team),association(:team) ] }
  end
end
