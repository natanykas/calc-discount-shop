# frozen_string_literal: true

module Api
  module V1
    # PRO: Clean controller for CRUD usage
    # CON: Endpoints not on the requirements
    class ExceptionCollectionsController < ApplicationController
      before_action :set_exception_collection, only: %i[show update destroy]

      def index
        @exception_collections = ExceptionCollection.all
        render json: @exception_collections
      end

      def show
        render json: @exception_collection
      end

      def create
        @exception_collection = ExceptionCollection.new(exception_collection_params)

        if @exception_collection.save
          render json: @exception_collection, status: :created
        else
          render json: @exception_collection.errors, status: :unprocessable_entity
        end
      end

      def update
        if @exception_collection.update(exception_collection_params)
          render json: @exception_collection
        else
          render json: @exception_collection.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @exception_collection.destroy
        head :no_content
      end

      private

      def set_exception_collection
        @exception_collection = ExceptionCollection.find(params[:id])
      end

      def exception_collection_params
        params.require(:exception_collection).permit(:name)
      end
    end
  end
end
