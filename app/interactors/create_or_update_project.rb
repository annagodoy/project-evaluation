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
    end

    create_projetc_evaluations
  end

  def create_projetc_evaluations
    context.evaluations.each do |evaluation_params|
      new_evaluation = project.evaluations.create(title: evaluation_params[:title])

      create_evaluation_grades(evaluation_params, new_evaluation)

      calculate_weighted_score(new_evaluation)

      calculate_project_score

      context.project = project
    end
  end

  def create_evaluation_grades(params, new_evaluation)
    params[:grades].each do |grade|
      new_evaluation.grades.create(
        score: grade[:score].to_f.round(2),
        criterion_id: grade[:criteria][:id]
      )
    end
  end

  def calculate_weighted_score(new_evaluation)
    formula  = 0
    criteria = 0

    new_evaluation.grades.each do |grade|
      formula   += grade.score * grade.criterion.weight
      criteria  += grade.criterion.weight
    end

    weighted_score = (formula / criteria).round(2)

    new_evaluation.update_attribute('weighted_score', weighted_score)
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