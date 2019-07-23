# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'dry/container/stub'

RSpec.describe MatchMetric::CheckMatchMetric do
  let(:team_1) { build(:team) }
  let(:team_2) { build(:team) }
  let(:player) { create(:player, team: team_1) }
  let(:match) { create(:match, teams: [team_1, team_2]) }
  let(:metric) { create(:metric) }
  let(:params) { build(:valid_check_match_metric_params, player_id: player.id, metric_id: metric.id).to_h }
  let(:result) do
    MatchMetric::CheckMatchMetric.new.call(params: params)
  end

  context 'when correct params' do
    before { create(:match_metric, player_id: player.id, metric_id: metric.id, match_id: match.id) }
    it 'returns true' do
      expect(result).to be true
    end
  end
end
