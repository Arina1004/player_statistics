# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'dry/container/stub'

RSpec.describe Player::TopFivePlayers do
  let(:team_1) { build(:team) }
  let(:team_2) { build(:team) }
  let(:team_3) { build(:team) }
  let(:player) { create(:player, team: team_1) }
  let(:match) { create(:match, teams: [team_1, team_2]) }
  let(:metric) { create(:metric) }
  let(:metric_2) { create(:metric) }
  let(:params) { build(:valid_top_five_players_params, team: team_1, metric: metric).to_h }
  let(:result) do
    Player::TopFivePlayers.new.call(params: params)
  end
  describe 'when correct params' do
    before { create(:match_metric, player: player, metric: metric, match: match) }
    context 'with team' do
      it 'returns player' do
        expect(result).to eq([{ player: player, sum: 1 }])
      end
    end
    context 'wihout team' do
      let(:params) { build(:valid_top_five_players_without_team_params, metric: metric).to_h }
      it 'returns player' do
        expect(result).to eq([{ player: player, sum: 1 }])
      end
    end
  end

  describe 'when corrent params' do
    before { create(:match_metric, player: player, metric: metric_2, match: match) }
    context 'but metric not found' do
      it 'returns []' do
        expect(result).to eq([])
      end
    end
    context 'wihout team but metric not found ' do
      let(:params) { build(:valid_top_five_players_without_team_params, metric: metric).to_h }
      it 'returns []' do
        expect(result).to eq([])
      end
    end

    context 'but team not found ' do
      let(:params) { build(:valid_top_five_players_without_team_params, metric: metric_2, team: team_3).to_h }
      it 'returns []' do
        expect(result).to eq([])
      end
    end
  end

  describe 'when wrong params' do
    before { create(:match_metric, player: player, metric: metric, match: match) }

    context  'metric not valid param' do
      let(:params) { build(:valid_top_five_players_params, metric: nil).to_h }
      it 'returns Failure' do
        expect(result).to be_kind_of(Dry::Monads::Result::Failure)
      end
      it 'returns {:metric=>["must be filled"]}' do
        expect(result.failure).to eq(metric: ['must be filled'])
      end
    end
  end
end
