module Api
  module V1
    class ProjectsController < ApplicationController

      def index
        projects = Project.all.order(name: :asc)

        result = Kaminari.paginate_array(
          ProjectSerializer.wrap(projects),
          total_count: projects.count
        ).page(params[:page] || 1).per(params[:size] || 25)

        render json: result
      end

      def projects
        result = CreateOrUpdateProject.call(project_params)
        render json: ProjectSerializer.new(result.project).serialized_json
      end

      private

      def project_params
        params.require(:project).permit(
          :id,
          :name,
          evaluations: [
            :id,
            :title,
            grades: [
              :id,
              :score,
              criteria: [
                :id
              ]
            ]
          ]
        )
      end
    end
  end
end