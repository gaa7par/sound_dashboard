require 'rails_helper'

describe Admin::RecordersController do
  let!(:room) { create(:room) }

  describe '#create' do
    let(:call_request) { post :create, room_id: room.id, recorder: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:recorder, name: '#01', position_x: 20, position_y: 5) }

      it { expect { call_request }.to change { Recorder.count }.by(1) }

      context 'after request' do
        before { call_request }

        let(:recorder) { Recorder.last }

        it { expect(recorder.name).to eq '#01' }
        it { expect(recorder.position_x).to eq 20 }
        it { expect(recorder.position_y).to eq 5 }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:recorder, name: nil, position_x: nil, position_y: nil) }

      it { expect { call_request }.not_to change { Recorder.count } }

      context 'after request' do
        before { call_request }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, room_id: room.id, id: recorder.id }
    let!(:recorder) { create(:recorder, room: room) }

    it { expect { call_request }.to change { Recorder.count }.by(-1) }

    context 'after request' do
      before { call_request }
    end
  end
end
