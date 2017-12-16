require 'rails_helper'
require 'support/controllers_contexts'

RSpec.describe ProductsController, type: :controller do
  let(:product) { create(:product) }

  describe '#show' do
    describe 'GET' do
      before { get :show, params: { id: product.id }, format: :json }
      it_behaves_like '200 ok'

      it "assigns all #{:product.to_s.pluralize} as @#{:product.to_s.pluralize}" do
        expect(response.body).to eq(product.to_json)
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
