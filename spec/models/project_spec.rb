require 'rails_helper'

RSpec.describe Project, type: :model do
  context 'Validations' do

    it 'is valid with valid attributes' do
      project = build(:project)
      expect(project).to be_valid
    end

    it 'is not valid without a name' do
      project = build(:project, name: nil)
      expect(project).to_not be_valid
    end
  end
end