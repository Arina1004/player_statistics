# frozen_string_literal: true

class Metric < ActiveRecord::Base
  validates :name, presence: true
end
