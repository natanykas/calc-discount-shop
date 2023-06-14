# frozen_string_literal: true

class ExceptionCollection < ApplicationRecord
  validates :name, presence: true
end
