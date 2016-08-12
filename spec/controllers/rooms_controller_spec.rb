require 'rails_helper'

describe Admin::RoomsController do
  let(:admin) { create(:admin) }
  before { sign_in admin }

  describe '#index' do
    let(:call_request) { get :index }

    context 'after request' do
      before { call_request }

      it { should render_template 'index' }
    end
  end

  describe '#show' do
    let(:call_request) { get :show, id: room.id }
    let!(:room) { create(:room) }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:room)).to eq room }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:room).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: room.id }
    let!(:room) { create(:room) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:room)).to eq room }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, room: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:room, name: 'Master Builders', dimension_x: 30, dimension_y: 10) }

      it { expect { call_request }.to change { Room.count }.by(1) }

      context 'after request' do
        before { call_request }

        let(:room) { Room.last }

        it { should redirect_to  admin_room_path(room) }
        it { expect(room.name).to eq 'Master Builders' }
        it { expect(room.dimension_x).to eq 30 }
        it { expect(room.dimension_y).to eq 10 }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:room, name: nil, dimension_x: nil, dimension_y: nil) }

      it { expect { call_request }.not_to change { Room.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let(:room) { create(:room, name: 'Master Builders', dimension_x: 30, dimension_y: 10) }
    let(:call_request) { put :update, room: attributes, id: room.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:room, name: 'Other Room', dimension_x: 20, dimension_y: 20) }

      it { expect { call_request }.to change { room.reload.name }.from('Master Builders').to('Other Room') }
      it { expect { call_request }.to change { room.reload.dimension_x }.from(30).to(20) }
      it { expect { call_request }.to change { room.reload.dimension_y }.from(10).to(20) }

      context 'after request' do
        before { call_request }

        it { should redirect_to  admin_room_path(room) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:room, name: nil, dimension_x: nil, dimension_y: nil) }

      it { expect { call_request }.not_to change { room.reload.name } }
      it { expect { call_request }.not_to change { room.reload.dimension_x } }
      it { expect { call_request }.not_to change { room.reload.dimension_y } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: room.id }
    let!(:room) { create(:room) }

    it { expect { call_request }.to change { Room.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to  admin_rooms_path }
    end
  end
end
