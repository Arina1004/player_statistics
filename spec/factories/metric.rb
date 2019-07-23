# frozen_string_literal: true

FactoryBot.define do
  factory :metric_new, class: Metric do
  end

  factory :metric, class: Metric do
    name { Faker::Lorem.word }
  end
end
