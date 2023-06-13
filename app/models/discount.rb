class Discount < ApplicationRecord

    validates :quantity, :percentage, presence: true
end
