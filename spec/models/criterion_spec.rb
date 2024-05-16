require 'rails_helper'

RSpec.describe Criterion, type: :model do
  context 'Validations' do 
    
    it 'is valid with valid attributes' do
      criterion = build(:criterion)
      expect(criterion).to be_valid
    end

    it 'is not valid without a weight' do
      criterion = build(:criterion, weight: nil)
      expect(criterion).to_not be_valid
    end
  end
end