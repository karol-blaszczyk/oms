require 'rails_helper'
require 'support/controllers_contexts'

RSpec.describe StatusTransactionsController, type: :controller do
  let(:order) { create(:order) }

  describe '#show' do
    describe 'GET' do
      before { get :show, params: { order_id: order.id }, format: :json }
      it_behaves_like '200 ok'

      it "assigns all #{:status_transactions.to_s.pluralize} as @#{:status_transactions.to_s.pluralize}" do
        expect(response.body).to eq(order.aasm(:status).events.map(&:name).to_json)
      end
    end
    context 'GET not existing' do
      it do
        expect do
          get :show, params: { order_id: -1 }, format: :json
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe '#create' do
    describe 'GET' do
      it 'changes state of order' do
        expect do
          post :create, params: {
            order_id: order.id, status_transaction: { event: 'place_order' }
          }, format: :json
        end.to change { order.reload.status }.from('draft').to('placed')
      end
      it 'invalid state fails' do
        post :create, params: {
          order_id: order.id, status_transaction: { event: 'dupa' }
        }, format: :json
        expect(response.status).to eq(422)
      end
    end
  end
end
