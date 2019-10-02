# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'dry/container/stub'

RSpec.describe ::Player do
  let(:team_1) { build(:team) }
  let(:team_2) { build(:team) }
  let(:player) { build(:player, team: team_1) }
  let(:match) { build(:match, teams: [team_1, team_2]) }
  let(:metric) { build(:metric) }
  let(:metric_2) { build(:metric) }
  let(:result) do
    player.check_match_metric(metric)
  end

  describe do
    before { create(:match_metric, player: player, metric: metric, match: match) }
    context 'with correct params' do
      it { expect(result).to be true }
    end

    context 'with correct params, but metric not found' do
      let(:result) do
        player.check_match_metric(metric_2)
      end
      it { expect(result).to be false }
    end

    context 'with wrong params' do
      before { create(:match_metric, player: player, metric: metric, match: match) }

      context  'metric is nil' do
        let(:result) do
          player.check_match_metric(nil)
        end
        it { expect(result).to be_kind_of(NoMethodError) }
      end
    end
  end
end
