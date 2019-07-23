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
  let(:object) { build(:match_metric, player_id: player.id, match_id: match.id, metric_id: metric.id) }
  let(:params) { build(:valid_match_metric_params, player_id: player.id, match_id: match.id, metric_id: metric.id).to_h }
  let(:result) do
    MatchMetric::CreateMatchMetric.new.call(params: params)
  end

  context 'when correct params' do
    it 'returns not error' do
      expect { result }.not_to raise_error
    end
  end

  # describe 'params[:starts_at]' do
  #   context 'when params[:starts_at] is a valid date' do
  #     let(:params) { build(:valid_reservation_params, start_date: '2019-06-26').to_h }
  #     it 'returns Success' do
  #       expect(result).to be_kind_of(Dry::Monads::Result::Success)
  #     end
  #     it 'sets reservation.starts_at to params[:start_date]' do
  #       expect(result.value!.starts_at).to eq(DateTime.new(2019, 6, 26, 0, 0, 0))
  #     end
  #   end

  #   context 'when params[:starts_at] is not a valid date' do
  #     let(:params) { build(:valid_reservation_params, start_date: nil).to_h }
  #     it 'returns Failure' do
  #       expect(result).to be_kind_of(Dry::Monads::Result::Failure)
  #     end
  #     it 'returns ValidationError' do
  #       expect(result.failure).to be_kind_of(GoBaby::ValidationError)
  #     end
  #   end
  # end
end
