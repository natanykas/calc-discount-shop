# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ExceptionCollections', type: :request do
  describe 'GET /api/v1/exception_collections' do
    it 'returns a list of discounts' do
      create_list(:exception_collection, 3)

      get '/api/v1/exception_collections'

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/v1/exception_collections/:id' do
    it 'returns a single discount' do
      exception_collection = create(:exception_collection)
      get "/api/v1/exception_collections/#{exception_collection.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(exception_collection.id)
    end
  end

  describe 'POST /api/v1/exception_collections' do
    context 'with valid parameters' do
      it 'creates a new exception collection' do
        exception_collection_params = attributes_for(:exception_collection)

        post '/api/v1/exception_collections', params: { exception_collection: exception_collection_params }

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)['name']).to eq(exception_collection_params[:name])
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new exception collection' do
        exception_collection_params = { name: '' }

        post '/api/v1/exception_collections', params: { exception_collection: exception_collection_params }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /api/v1/exception_collections/:id' do
    context 'with valid parameters' do
      it 'updates the exception collection' do
        exception_collection = create(:exception_collection)
        name = 'Default'

        patch "/api/v1/exception_collections/#{exception_collection.id}",
              params: { exception_collection: { name: } }

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['name']).to eq(name)
      end
    end

    context 'with invalid parameters' do
      it 'does not update the exception collection' do
        exception_collection = create(:exception_collection)
        original_name = exception_collection.name

        patch "/api/v1/exception_collections/#{exception_collection.id}",
              params: { exception_collection: { name: '' } }

        expect(response).to have_http_status(:unprocessable_entity)
        expect(exception_collection.reload.name).to eq(original_name)
      end
    end
  end

  describe 'DELETE /api/v1/exception_collections/:id' do
    it 'deletes the exception_collection' do
      exception_collection = create(:exception_collection)

      expect do
        delete "/api/v1/exception_collections/#{exception_collection.id}"
      end.to change(ExceptionCollection, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
