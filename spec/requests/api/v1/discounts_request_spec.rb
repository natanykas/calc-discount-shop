# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Discounts', type: :request do
  describe 'GET /api/v1/discounts' do
    it 'returns a list of discounts' do
      create_list(:discount, 3)

      get '/api/v1/discounts'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/v1/discounts/:id' do
    it 'returns a single discount' do
      discount = create(:discount)

      get "/api/v1/discounts/#{discount.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(discount.id)
    end
  end

  describe 'POST /api/v1/discounts' do
    context 'with valid parameters' do
      it 'creates a new discount' do
        discount_params = attributes_for(:discount)

        post '/api/v1/discounts', params: { discount: discount_params }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['quantity']).to eq(discount_params[:quantity])
        expect(JSON.parse(response.body)['percentage']).to eq(discount_params[:percentage])
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new discount' do
        discount_params = { quantity: '', percentage: 5 }

        post '/api/v1/discounts', params: { discount: discount_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /api/v1/discounts/:id' do
    context 'with valid parameters' do
      it 'updates the discount' do
        discount = create(:discount)
        new_quantity = 10

        patch "/api/v1/discounts/#{discount.id}", params: { discount: { quantity: new_quantity } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['quantity']).to eq(new_quantity)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the discount' do
        discount = create(:discount)
        original_quantity = discount.quantity

        patch "/api/v1/discounts/#{discount.id}", params: { discount: { quantity: '', percentage: 5 } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(discount.reload.quantity).to eq(original_quantity)
      end
    end
  end

  describe 'DELETE /api/v1/discounts/:id' do
    it 'deletes the discount' do
      discount = create(:discount)

      expect do
        delete "/api/v1/discounts/#{discount.id}"
      end.to change(Discount, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
