# frozen_string_literal: true

class CreateExceptionCollections < ActiveRecord::Migration[7.0]
  def change
    create_table :exception_collections do |t|
      t.string :name

      t.timestamps
    end
  end
end
