# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'dry/container/stub'

RSpec.describe MatchMetric::CreateMatchMetric do
  let(:team_1) { build(:team) }
  let(:team_2) { build(:team) }
  let(:player) { create(:player, team: team_1) }
  let(:match) { create(:match, teams: [team_1, team_2]) }
  let(:metric) { create(:metric) }
  let(:object) { build(:match_metric, player: player, match: match, metric: metric) }
  let(:params) { build(:valid_match_metric_params, player: player, match: match, metric: metric).to_h }
  let(:result) do
    MatchMetric::CreateMatchMetric.new.call(params: params)
  end

  context 'when correct params' do
    it 'returns not error' do
      expect { result }.not_to raise_error
    end
  end

  describe 'params[:player]' do
    context 'when params[:player] is a valid' do
      it 'sets result.player to params[:player]' do
        expect(result.player).to eq(player)
      end
    end
    context 'when params[:player] is not valid' do
      let(:params) { build(:valid_match_metric_params, player: nil, match: match, metric: metric).to_h }
      it 'returns Failure' do
        expect(result).to be_kind_of(Dry::Monads::Result::Failure)
      end
      it 'sets result.player to params[:player]' do
        expect(result.failure).to eq(player: ['must be filled'])
      end
    end
  end

  describe 'params[:match]' do
    context 'when params[:match] is a valid' do
      it 'sets result.match to params[:match]' do
        expect(result.match).to eq(match)
      end
    end
    context 'when params[:player] is not valid' do
      let(:params) { build(:valid_match_metric_params, player: player, match: nil, metric: metric).to_h }
      it 'returns Failure' do
        expect(result).to be_kind_of(Dry::Monads::Result::Failure)
      end
      it 'sets result.match to params[:match]' do
        expect(result.failure).to eq(match: ['must be filled'])
      end
    end
  end

  describe 'params[:metric]' do
    context 'when params[:metric] is a valid' do
      let(:params) { build(:valid_match_metric_params, player: player, match: match, metric: metric).to_h }
      it 'sets result.player to params[:player]' do
        expect(result.metric).to eq(metric)
      end
    end
    context 'when params[:metric] is not valid' do
      let(:params) { build(:valid_match_metric_params, player: player, match: match, metric: nil).to_h }
      it 'returns Failure' do
        expect(result).to be_kind_of(Dry::Monads::Result::Failure)
      end
      it 'sets result.metric to params[:metric]' do
        expect(result.failure).to eq(metric: ['must be filled'])
      end
    end
  end
end
