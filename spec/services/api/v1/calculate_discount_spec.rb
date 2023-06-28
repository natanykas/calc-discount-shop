# frozen_string_literal: true

require 'rails_helper'

# CON: Only 1 test case for the discount calculation logic. Could
# probably have added many other cases like when the list is empty, or
# when there is more than 5 items for exemple.
RSpec.describe Api::V1::CalculateDiscount do
  context 'when calculate discount' do
    before do
      create(:exception_collection, name: 'KETO')
      create(:discount, quantity: 2, percentage: 5)
      create(:discount, quantity: 3, percentage: 10)
      create(:discount, quantity: 4, percentage: 20)
      create(:discount, quantity: 5, percentage: 25)
    end

    it 'returns discount and total price' do
      cart_info = {
        'reference' => '2d832fe0-6c96-4515-9be7-4c00983539c1',
        'lineItems' => [
          { 'name' => 'Peanut Butter', 'price' => '39.0', 'collection' => 'BEST-SELLERS' },
          { 'name' => 'Banana Cake', 'price' => '34.99', 'collection' => 'DEFAULT' },
          { 'name' => 'Cocoa', 'price' => '34.99', 'collection' => 'KETO' },
          { 'name' => 'Fruity', 'price' => '32', 'collection' => 'DEFAULT' }
        ]
      }

      service = described_class.call(cart_info)
      expect(service.cart_info['total']).to eq('130.38')
    end
  end
end
