require 'rails_helper'
require 'support/controllers_contexts'

RSpec.describe LineItemsController, type: :controller do
  let(:line_item) { create(:line_item) }

  describe '#show' do
    describe 'GET' do
      before { get :show, params: { id: line_item.id, order_id: line_item.order.id }, format: :json }
      it_behaves_like '200 ok'

      it "assigns all #{:line_item.to_s.pluralize} as @#{:line_item.to_s.pluralize}" do
        expect(response.body).to eq(line_item.to_json)
      end
    end
    context 'GET not existing' do
      it do
        expect do
          get :show, params: { id: -1, order_id: line_item.order.id }, format: :json
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
