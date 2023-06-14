# frozen_string_literal: true

class CreateDiscounts < ActiveRecord::Migration[7.0]
  def change
    create_table :discounts do |t|
      t.integer :quantity
      t.integer :percentage

      t.timestamps
    end
  end
end
