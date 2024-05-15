class UpdateScores
  include Interactor

  def call
    raise 'criterio não pode ser vazio!' if context.criterion.blank?

    update_scores
  rescue => e
    context.fail!(error: e.message)
  end

  private

  def update_scores
    formula  = 0
    criteria = 0

    context.criterion.grades.each do |grade|
      formula   += grade.score * grade.criterion.weight
      criteria  += grade.criterion.weight

      weighted_score = (formula / criteria).round(2)
      
      grade.evaluation.update_attribute('weighted_score', weighted_score)
      
      update_project_score(grade.evaluation.project)
    end
  end

  def update_project_score(project)
    score = 0

    project.evaluations.each do |evaluation|
      score += evaluation.weighted_score
    end

    total_score = (score / project.evaluations.count).round(2)

    project.update_attribute('total_score', total_score)
  end
end