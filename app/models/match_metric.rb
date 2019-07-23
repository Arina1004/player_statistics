# frozen_string_literal: true

class MatchMetric < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  belongs_to :metric

  scope :top_five, -> { group(:player_id).order(sum: :desc).limit(5) }
end
