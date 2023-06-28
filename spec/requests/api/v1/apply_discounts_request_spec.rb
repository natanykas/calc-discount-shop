# frozen_string_literal: true

require 'rails_helper'

# PRO: Controller tests
RSpec.describe 'Api::V1::ApplyDiscounts', type: :request do
  describe 'POST /api/v1/apply_discounts' do
    before do
      create(:exception_collection, name: 'KETO')
      create(:discount, quantity: 2, percentage: 5)
      create(:discount, quantity: 3, percentage: 10)
      create(:discount, quantity: 4, percentage: 20)
      create(:discount, quantity: 5, percentage: 25)
    end

    context 'with valid parameters' do
      it 'returns the discount' do
        cart_params = {
          reference: '2d832fe0-6c96-4515-9be7-4c00983539c1',
          lineItems: [
            { 'name': 'Peanut Butter', 'price': '39.0', 'collection': 'BEST-SELLERS' },
            { 'name': 'Banana Cake', 'price': '34.99', 'collection': 'DEFAULT' },
            { 'name': 'Cocoa', 'price': '34.99', 'collection': 'KETO' },
            { 'name': 'Fruity', 'price': '32', 'collection': 'DEFAULT' }
          ]
        }

        post '/api/v1/apply_discounts', params: { cart: cart_params }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['cart']['total']).to eq('130.38')
      end
    end
  end
end
