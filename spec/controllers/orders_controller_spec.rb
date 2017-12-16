require 'rails_helper'
require 'support/controllers_contexts'

RSpec.describe OrdersController, type: :controller do
  let(:order) { create(:order) }

  describe '#show' do
    describe 'GET' do
      before { get :show, params: { id: order.id }, format: :json }
      it_behaves_like '200 ok'

      it "assigns all #{:order.to_s.pluralize} as @#{:order.to_s.pluralize}" do
        expect(response.body).to eq(order.to_json)
      end
    end
    context 'GET not existing' do
      it do
        expect do
          get :show, params: { id: -1 }, format: :json
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
