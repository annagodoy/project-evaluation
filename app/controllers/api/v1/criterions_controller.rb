module Api
  module V1
    class CriterionsController < ApplicationController

      def criterions
        result = CreateOrUpdateCriterion.call(criterion_params)
        render json: { criterio: result.criterion, status: 200 }
      end

      private

      def criterion_params
        params.require(:criterion).permit(:id, :weight)
      end

      def get_criterions
        criterion = Criterion.all
      end
    end
  end
end