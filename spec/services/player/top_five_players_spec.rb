# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'dry/container/stub'

RSpec.describe Player::TopFivePlayers do
  let(:team_1) { build(:team) }
  let(:team_2) { build(:team) }
  let(:team_3) { build(:team) }
  let(:player) { build(:player, team: team_1) }
  let(:match) { build(:match, teams: [team_1, team_2]) }
  let(:metric) { build(:metric) }
  let(:metric_2) { build(:metric) }
  let(:params) { build(:valid_top_five_players_params, team: team_1, metric: metric).to_h }
  let(:result) do
    Player::TopFivePlayers.new.call(params: params)
  end
  describe 'with  correct params' do
    before { create(:match_metric, player: player, metric: metric, match: match) }
    context 'with team' do
      it { expect(result).to eq([{ player: player, sum: 1 }]) }
    end
    context 'wihout team' do
      let(:params) { build(:valid_top_five_players_without_team_params, metric: metric).to_h }
      it { expect(result).to eq([{ player: player, sum: 1 }]) }
    end
  end

  describe 'with  corrent params' do
    before { create(:match_metric, player: player, metric: metric_2, match: match) }
    context 'but metric not found' do
      it { expect(result).to eq([]) }
    end
    context 'wihout team but metric not found ' do
      let(:params) { build(:valid_top_five_players_without_team_params, metric: metric).to_h }
      it { expect(result).to eq([]) }
    end

    context 'but team not found ' do
      let(:params) { build(:valid_top_five_players_without_team_params, metric: metric_2, team: team_3).to_h }
      it { expect(result).to eq([]) }
    end
  end

  describe 'with  wrong params' do
    before { create(:match_metric, player: player, metric: metric, match: match) }

    context  'metric not valid param' do
      let(:params) { build(:valid_top_five_players_params, metric: nil).to_h }
      it { expect(result).to be_kind_of(Dry::Monads::Result::Failure) }

      it { expect(result.failure).to eq(metric: ['must be filled']) }
    end
  end
end
