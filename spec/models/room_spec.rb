require 'rails_helper'

RSpec.describe Room do
  it 'has valid factory' do
    expect(build(:room)).to be_valid
  end

  describe '#measures_per_days_chart' do
    let(:room) { create(:room) }
    let(:recorder_1) { create(:recorder, room: room) }

    context 'many recorders exists' do
      let(:recorder_2) { create(:recorder, room: room) }
      before do
        create(:measurement, recorder: recorder_1, time: Time.now.beginning_of_day+8.hours, measure: 10)
        create(:measurement, recorder: recorder_1, time: Time.now.beginning_of_day+8.hours+5.minutes, measure: 8)
        create(:measurement, recorder: recorder_1, time: Time.now.beginning_of_day+8.hours+10.minutes, measure: 6)
        create(:measurement, recorder: recorder_2, time: Time.now.beginning_of_day+8.hours, measure: 4)
        create(:measurement, recorder: recorder_2, time: Time.now.beginning_of_day+8.hours+5.minutes, measure: 2)
        create(:measurement, recorder: recorder_2, time: Time.now.beginning_of_day+8.hours+10.minutes, measure: 0)
      end

      let(:perform) { room.measures_per_days_chart }

      it 'returns array with average measures' do
        expect(perform).to eq [7, 5, 3]
      end
    end

    context 'measures for different days exist' do
      before do
        create(:measurement, recorder: recorder_1, measure: 10, time: Time.now.beginning_of_day+8.hours)
        create(:measurement, recorder: recorder_1, measure: 8, time: Date.yesterday.beginning_of_day+8.hours)
        create(:measurement, recorder: recorder_1, measure: 6, time: Date.parse('2016-01-01').beginning_of_day+8.hours)
      end

      it 'returns array with average measures for current day' do
        expect(room.measures_per_days_chart('today')).to eq [10]
      end

      it 'returns array with average measures for previous day' do
        expect(room.measures_per_days_chart('yesterday')).to eq [8]
      end

      it 'returns array with average measures for selected day' do
        expect(room.measures_per_days_chart('2016-01-01')).to eq [6]
      end
    end
  end

  describe '#coordinates_per_room_chart' do
    let!(:room) { create(:room, dimension_x: 3, dimension_y: 2) }
    let!(:recorder) { create(:recorder, room: room, position_x: 1, position_y: 1) }

    context 'rooms and recorders has their own coordinates' do

      let(:perform) { room.coordinates_per_room_chart }

      it 'returns array with coordinates' do
        expect(perform).to eq [[0, 0, 0], [0, 1, 0], [1, 0, 0], [1, 1, 0], [2, 0, 0], [2, 1, 0], [1.0, 1.0, 10]]
      end
    end
  end
end
