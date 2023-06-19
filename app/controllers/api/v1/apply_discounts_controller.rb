# frozen_string_literal: true

module Api
  module V1
    class ApplyDiscountsController < ApplicationController
      def calculate
        service = Api::V1::CalculateDiscount.call(cart_params.to_h)

        render json: { cart: service.cart_info }, status: :ok
      end

      private

      def cart_params
        params.require(:cart).permit(:reference, lineItems: %i[name price collection])
      end
    end
  end
end
