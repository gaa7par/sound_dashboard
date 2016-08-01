require 'rails_helper'

describe AdminsController do
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
    let(:call_request) { get :show, id: admin.id }

    context 'after request' do
      before { call_request }

      it { should render_template 'show' }
      it { expect(assigns(:admin)).to eq admin }
    end
  end

  describe '#new' do
    let(:call_request) { get :new }

    context 'after request' do
      before { call_request }

      it { should render_template 'new' }
      it { expect(assigns(:admin).persisted?).to be false }
    end
  end

  describe '#edit' do
    let(:call_request) { get :edit, id: admin.id }
    let!(:admin) { create(:admin) }

    context 'after request' do
      before { call_request }

      it { should render_template 'edit' }
      it { expect(assigns(:admin)).to eq admin }
    end
  end

  describe '#create' do
    let(:call_request) { post :create, admin: attributes }

    context 'valid request' do
      let(:attributes) { attributes_for(:admin, email: 'new_admin@example.com', password: 'secret', password_confirmation: 'secret') }

      it { expect { call_request }.to change { Admin.count }.by(1) }

      context 'after request' do
        before { call_request }

        let(:new_admin) { Admin.last }

        it { should redirect_to  admin_path(new_admin) }
        it { expect(new_admin.email).to eq 'new_admin@example.com' }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:admin, email: nil, password: nil, password_confirmation: nil) }

      it { expect { call_request }.not_to change { Admin.count } }

      context 'after request' do
        before { call_request }

        it { should render_template 'new' }
      end
    end
  end

  describe '#update' do
    let(:admin) { create(:admin, email: 'admin@example.com', password: 'secret', password_confirmation: 'secret') }
    let(:call_request) { put :update, admin: attributes, id: admin.id }

    context 'valid request' do
      let(:attributes) { attributes_for(:admin, email: 'other_admin@example.com', password: 'not_secret', password_confirmation: 'not_secret') }

      it { expect { call_request }.to change { admin.reload.email }.from('admin@example.com').to('other_admin@example.com') }

      context 'after request' do
        before { call_request }

        it { should redirect_to  admin_path(admin) }
      end
    end

    context 'invalid request' do
      let(:attributes) { attributes_for(:admin, email: nil, password: nil, password_confirmation: nil) }

      it { expect { call_request }.not_to change { admin.reload.email } }
      it { expect { call_request }.not_to change { admin.reload.password } }
      it { expect { call_request }.not_to change { admin.reload.password_confirmation } }

      context 'after request' do
        before { call_request }

        it { should render_template 'edit' }
      end
    end
  end

  describe '#destroy' do
    let(:call_request) { delete :destroy, id: admin.id }
    let!(:admin) { create(:admin) }

    it { expect { call_request }.to change { Admin.count }.by(-1) }

    context 'after request' do
      before { call_request }

      it { should redirect_to  admins_path }
    end
  end
end
