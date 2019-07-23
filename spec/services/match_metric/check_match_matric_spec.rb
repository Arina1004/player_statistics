# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'dry/container/stub'

RSpec.describe do
  let(:team_1) { build(:team) }
  let(:team_2) { build(:team) }
  let(:player) { create(:player, team: team_1) }
  let(:match) { create(:match, teams: [team_1, team_2]) }
  let(:metric) { create(:metric) }
  let(:metric_2) { create(:metric) }
  let(:result) do
    player.check_match_metric(metric)
  end

  describe do
    before { create(:match_metric, player: player, metric: metric, match: match) }
    context 'when correct params' do
      it 'returns true' do
        expect(result).to be true
      end
    end

    context 'when correct params, but metric not found' do
      let(:result) do
        player.check_match_metric(metric_2)
      end
      it 'returns false' do
        expect(result).to be false
      end
    end
  end

  describe 'when wrong params' do
    before { create(:match_metric, player: player, metric: metric, match: match) }

    context  'metric is nil' do
      let(:result) do
        player.check_match_metric(nil)
      end
      it 'returns error' do
        expect(result).to be_kind_of(NoMethodError)
      end
      it 'returns {:metric=>["must be filled"]}' do
        expect(result.message).to eq("undefined method `id' for nil:NilClass")
      end
    end
  end

end
