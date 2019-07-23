class Match < ActiveRecord::Base
  has_many :match_metrics, class_name: 'MatchMetric'
  has_many :players, through: :match_metrics
  has_many :metrics, through: :match_metrics
  has_and_belongs_to_many :teams

  scope :last_five, -> { order(date: :desc).limit(5)}


end