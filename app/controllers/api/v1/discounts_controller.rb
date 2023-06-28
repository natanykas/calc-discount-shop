# frozen_string_literal: true

module Api
  module V1
    # PRO: Clean controller for CRUD usage
    # CON: Endpoints not on the requirements
    class DiscountsController < ApplicationController
      before_action :set_discount, only: %i[show update destroy]

      def index
        @discounts = Discount.all
        render json: @discounts
      end

      def show
        render json: @discount
      end

      def create
        @discount = Discount.new(discount_params)

        if @discount.save
          render json: @discount, status: :created
        else
          render json: @discount.errors, status: :unprocessable_entity
        end
      end

      def update
        if @discount.update(discount_params)
          render json: @discount
        else
          render json: @discount.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @discount.destroy
        head :no_content
      end

      private

      def set_discount
        @discount = Discount.find(params[:id])
      end

      def discount_params
        params.require(:discount).permit(:quantity, :percentage)
      end
    end
  end
end
