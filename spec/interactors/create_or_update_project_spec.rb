require 'rails_helper'

RSpec.describe CreateOrUpdateProject do
  describe '.call' do 
    let(:name)        { }
    let(:evaluations) { }
    let(:criterion1)  { CreateOrUpdateCriterion.call(weight: 2.0) }
    let(:criterion2)  { CreateOrUpdateCriterion.call(weight: 5.0) }
    let(:evaluations) {
      [
        {
          title: 'Pink',
          grades: [
            {
              score: 4.5,
              criteria: {
                id: criterion1.criterion.id
              }
            },
            {
              score: 7.0,
              criteria: {
                id: criterion2.criterion.id
              }
            }
          ]
        }
      ]
    }

    subject(:interactor) { described_class.call(name: name, evaluations: evaluations) }

    context 'create a project and their respectives evaluations and grades' do
      let(:name) { 'Springwater' }

      before do 
        interactor
      end

      it 'should create a project, evaluations and grades' do
        expect(interactor.project.evaluations.map(&:grades).first.count).to eq 2
      end
    end

    context 'update a project' do
      let(:name)  { 'Ambapur Nagla' }
      let(:name2) { 'Updated' }
      
      before do 
        interactor
        described_class.call(name: name2, id: interactor.project.id)
        interactor.project.reload
      end

      it 'should update the project name' do
        expect(interactor.project.name).to eq name2
      end
    end
  end
end