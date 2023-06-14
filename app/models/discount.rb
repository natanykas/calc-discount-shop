# frozen_string_literal: true

class Discount < ApplicationRecord
  validates :quantity, :percentage, presence: true
end
