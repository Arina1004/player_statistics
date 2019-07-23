
# frozen_string_literal: true


unless Rails.env.production?
  require File.join(File.dirname(__FILE__), 'seeds/team.rb')
  require File.join(File.dirname(__FILE__), 'seeds/metric.rb')
  require File.join(File.dirname(__FILE__), 'seeds/player.rb')
  require File.join(File.dirname(__FILE__), 'seeds/match.rb')
  require File.join(File.dirname(__FILE__), 'seeds/match_metric.rb')
end

Dir[File.join(__dir__, 'models', '*.rb')].each { |file| require file }





