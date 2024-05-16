require 'rails_helper'

RSpec.describe Evaluation, type: :model do
  context 'Validations' do
    let(:project)       { create(:project) }

    it 'is valid with valid attributes' do
      evaluation = build(:evaluation, project_id: project.id)
      expect(evaluation).to be_valid
    end

    it 'is not valid without a project_id' do
      evaluation = build(:evaluation)
      expect(evaluation).to_not be_valid
    end

    it 'is not valid without a title' do
      evaluation = build(:evaluation, title: nil, project_id: project.id)
      expect(evaluation).to_not be_valid
    end
  end
end