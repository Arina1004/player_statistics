class Team < ActiveRecord::Base
  has_many :players
  has_and_belongs_to_many :matches

end