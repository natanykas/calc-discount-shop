require 'rails_helper'

RSpec.describe ExceptionCollection, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
