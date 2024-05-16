require 'rails_helper'
require 'faker'

RSpec.describe UpdateScores do
  describe '.call' do
    let(:criterion)     {  }
    let(:project_params){
      {
        name: 'Springwater',
        evaluations: [
          {
            title: 'Coral',
            grades: [
              {
                score: 8.5,
                criteria: {
                  id: criterion1.criterion.id
                }
              },
              {
                score: 10.0,
                criteria: {
                  id: criterion2.criterion.id
                }
              }
            ]
          },
          {
            title: 'Cyan',
            grades: [
              {
                score: 7.2,
                criteria: {
                  id: criterion2.criterion.id
                }
              },
              {
                score: 9.3,
                criteria: {
                  id: criterion1.criterion.id
                }
              }
            ]
          }
        ]
      }
    }

    let(:criterion1) { CreateOrUpdateCriterion.call(weight: 1.0) }
    let(:criterion2) { CreateOrUpdateCriterion.call(weight: 2.0) }
    let(:call)       { CreateOrUpdateProject.call(project_params)}

    subject(:interactor) { described_class.call(criterion: criterion) }

    context 'update grades and evaluation scores' do 
      context 'with valid params' do
        let(:criterion)  { criterion2.criterion }

        before do
          criterion2.criterion.update_attribute('weight', 4.0)
          interactor
          call.project.reload
        end

        it 'should update scores' do
          expect(call.project.total_score).to eq 8.66
        end
      end

      context 'with invalid params' do 
        before do
          interactor
        end

        it 'should return an error' do
          expect(interactor.error).to match(/criterio não pode ser vazio!/)
        end
      end
    end
  end
end