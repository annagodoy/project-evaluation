require 'rails_helper'

RSpec.describe Grade, type: :model do
  context 'Validations' do
    let(:evaluation) { create(:evaluation) }
    let(:criterion)  { create(:criterion) }

    it 'is valid with valid attributes' do
      grade = build(:grade, evaluation_id: evaluation.id, criterion_id: criterion.id)
      expect(grade).to be_valid
    end

    it 'is not valid without a score' do
      grade = build(:grade, score: nil, evaluation_id: evaluation.id, criterion_id: criterion.id)
      expect(grade).to_not be_valid
    end

    it 'is not valid without a evaluation_id' do
      grade = build(:grade, criterion_id: criterion.id)
      expect(grade).to_not be_valid
    end

    it 'is not valid without a criterion_id' do
      grade = build(:grade, evaluation_id: evaluation.id)
      expect(grade).to_not be_valid
    end
  end
end