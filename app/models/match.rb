# frozen_string_literal: true

class Match < ActiveRecord::Base
  has_many :match_metrics, class_name: 'MatchMetric'
  has_many :players, through: :match_metrics
  has_many :metrics, through: :match_metrics
  has_and_belongs_to_many :teams

  validates :name, presence: true
  validates :date, presence: true
  validates :teams, presence: true

  scope :last_five, -> { order(date: :desc).limit(5) }
end
