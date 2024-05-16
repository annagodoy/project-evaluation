class CreateOrUpdateProject
  include Interactor

  def call
    save_project
  rescue => e
    context.fail!(error: e.message)
  end

  private

  def project
    @project ||= Project.find_by(id: context.id)
  end

  def save_project
    if project.blank?
      @project = Project.create(name: context.name)
    else
      project.update_attribute('name', context.name)
    end

    create_or_update_project_evaluations
    context.project = project
  end

  def create_or_update_project_evaluations
    context.evaluations&.each do |evaluation_params|
      evaluation = project.evaluations.find_or_create_by(id: evaluation_params[:id])

      evaluation.update_attribute('title', evaluation_params[:title])
      evaluation_grades(evaluation_params, evaluation)
      calculate_weighted_score(evaluation)
      calculate_project_score
    end
  end

  def evaluation_grades(params, evaluation)
    params[:grades].each do |grade|
      evaluation.grades.find_or_initialize_by(id: grade[:id]).tap do |g|

        g.score = grade[:score].to_f.round(2)

        if g.new_record?
          g.criterion_id = grade[:criteria][:id]
        end

        g.save
      end
    end
  end

  def calculate_weighted_score(evaluation)
    formula  = 0
    criteria = 0

    evaluation.grades.each do |grade|
      formula   += grade.score * grade.criterion.weight
      criteria  += grade.criterion.weight
    end

    weighted_score = (formula / criteria).round(2)

    evaluation.update_attribute('weighted_score', weighted_score)
  end

  def calculate_project_score
    score = 0

    project.evaluations.each do |evaluation|
      score += evaluation.weighted_score
    end

    total_score = (score / project.evaluations.count).round(2)

    project.update_attribute('total_score', total_score)
  end
end