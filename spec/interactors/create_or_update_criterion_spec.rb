require 'rails_helper'

RSpec.describe CreateOrUpdateCriterion do
  describe '.call' do 
    let(:weight) { }
    let(:id)     { }

    subject(:interactor) { described_class.call(weight: weight, id: id) }

    context 'create a criterion' do 
      context 'with valid params' do
        let(:weight) { 7.0 }

        before do
          interactor
        end

        it 'should create a criterion' do
          expect(interactor.criterion.weight).to eq weight
        end
      end

      context 'without valid params' do 
        before do
          interactor
        end

        it 'should return an error' do
          expect(interactor.error).to match(/peso não pode ser vazio!/)
        end
      end
    end

    context 'update a criterion' do
      context 'with valid params' do
        let(:criterion) { create(:criterion) }
        let(:weight)    { 2.0 }
        let(:id)        { criterion.id }

        before do
          interactor
        end

        it 'should update a criterion' do
          expect(interactor.criterion.weight).to eq weight
        end
      end

      context 'without valid params' do 
        let(:criterion) { create(:criterion) }
        let(:id)        { criterion.id }

        before do
          interactor
        end

        it 'should return an error' do
          expect(interactor.error).to match(/peso não pode ser vazio!/)
        end
      end
    end
  end
end