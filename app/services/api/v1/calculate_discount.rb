# frozen_string_literal: true

module Api
  module V1
    class CalculateDiscount
      include Memery

      attr_accessor :cart_info, :line_items

      def initialize(cart_info)
        self.cart_info = cart_info
        self.line_items = cart_info['lineItems']
      end

      def self.call(*args)
        new(*args).call
      end

      def call
        apply_discounts && calc_total

        self
      end

      private

      def apply_discounts
        line_items.each do |item|
          next item['discount'] = '0' if exception_collection.include?(item['collection'])

          item['discount'] = calc_discount(item)
        end
      end

      def calc_discount(item)
        (item['price'].to_f * discount_percentage / 100).round(2).to_s
      end

      def calc_total
        cart_info['total'] = line_items.sum { |item| item['price'].to_f - item['discount'].to_f }.to_s
      end

      memoize def discount_percentage
        return hash_discount_info.values.max unless hash_discount_info.keys.any? { |item| item > valid_items }

        hash_discount_info[valid_items]
      end

      memoize def valid_items
        line_items.count { |item| !exception_collection.include?(item['collection']) }
      end

      memoize def exception_collection
        ExceptionCollection.pluck(:name)
      end

      memoize def hash_discount_info
        Discount.pluck(:quantity, :percentage).to_h
      end
    end
  end
end
