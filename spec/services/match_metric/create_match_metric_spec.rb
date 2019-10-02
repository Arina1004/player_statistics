# frozen_string_literal: true

require 'spec_helper'
require 'rails_helper'
require 'dry/container/stub'

RSpec.describe MatchMetric::CreateMatchMetric do
  let(:team_1) { build(:team) }
  let(:team_2) { build(:team) }
  let(:player) { build(:player, team: team_1) }
  let(:match) { build(:match, teams: [team_1, team_2]) }
  let(:metric) { build(:metric) }
  let(:object) { build(:match_metric, player: player, match: match, metric: metric) }
  let(:params) { build(:valid_match_metric_params, player: player, match: match, metric: metric).to_h }
  let(:result) do
    MatchMetric::CreateMatchMetric.new.call(params: params)
  end

  context 'with  correct params' do
    it { expect { result }.not_to raise_error }
  end

  describe 'params[:player]' do
    context 'with  params[:player] is a valid' do
      it { expect(result.player).to eq(player) }
    end
    context 'with  params[:player] is not valid' do
      let(:params) { build(:valid_match_metric_params, player: nil, match: match, metric: metric).to_h }

      it { expect(result).to be_kind_of(Dry::Monads::Result::Failure) }
      it { expect(result.failure).to eq(player: ['must be filled']) }
    end
  end

  describe 'params[:match]' do
    context 'with  params[:match] is a valid' do
      it { expect(result.match).to eq(match) }
    end
    context 'with  params[:player] is not valid' do
      let(:params) { build(:valid_match_metric_params, player: player, match: nil, metric: metric).to_h }
      it { expect(result).to be_kind_of(Dry::Monads::Result::Failure) }

      it { expect(result.failure).to eq(match: ['must be filled']) }
    end
  end

  describe 'params[:metric]' do
    context 'with  params[:metric] is a valid' do
      let(:params) { build(:valid_match_metric_params, player: player, match: match, metric: metric).to_h }
      it { expect(result.metric).to eq(metric) }
    end
    context 'with  params[:metric] is not valid' do
      let(:params) { build(:valid_match_metric_params, player: player, match: match, metric: nil).to_h }
      it { expect(result).to be_kind_of(Dry::Monads::Result::Failure) }

      it { expect(result.failure).to eq(metric: ['must be filled']) }
    end
  end
end
