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
      let(:attributes) { attributes_for(:room, name: 'Master Builders') }

      it { expect { call_request }.to change { Room.count }.by(1) }

      context 'after request' do
        before { call_request }

        let(:room) { Room.last }

        it { should redirect_to  admin_room_path(room) }
        it { expect(room.name).to eq 'Master Builders' }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:room, name: nil) }

      it { expect { call_request }.not_to change { Room.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let(:room) { create(:room, name: 'Master Builders') }
    let(:call_request) { put :update, room: attributes, id: room.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:room, name: 'Other Room') }

      it { expect { call_request }.to change { room.reload.name }.from('Master Builders').to('Other Room') }

      context 'after request' do
        before { call_request }

        it { should redirect_to  admin_room_path(room) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:room, name: nil) }

      it { expect { call_request }.not_to change { room.reload.name } }

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
