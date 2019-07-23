# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'dry/container/stub'

RSpec.describe Player::TopFivePlayers do
  let(:team_1) { build(:team) }
  let(:team_2) { build(:team) }
  let(:player) { create(:player, team: team_1) }
  let(:match) { create(:match, teams: [team_1, team_2]) }
  let(:metric) { create(:metric) }
  let(:params) { build(:valid_top_five_players_params, team_id: team_1.id, metric_id: metric.id).to_h }
  let(:result) do
    Player::TopFivePlayers.new.call(params: params)
  end
  describe 'when correct params' do
    before { create(:match_metric, player_id: player.id, metric_id: metric.id, match_id: match.id) }
    context '' do
      it 'returns player' do
        expect(result).to eq([{ player_id: player.id, sum: 1 }])
      end
    end
    context 'wihout team' do
      let(:params) { build(:valid_top_five_players_without_team_params, metric_id: metric.id).to_h }
      it 'returns player' do
        expect(result).to eq([{ player_id: player.id, sum: 1 }])
      end
    end
  end
end
