module Api
  module V1
    class ProjectsController < ApplicationController
      before_action :get_projects, only: [:index]

      def index
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
          :page,
          :size,
          :id,
          :name,
          evaluations: [
            :title,
            grades: [
              :score,
              criteria: [
                :id
              ]
            ]
          ]
        )
      end

      def get_projects
        projects = Project.all.order(name: :asc)
      end
    end
  end
end