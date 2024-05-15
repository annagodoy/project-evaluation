class EvaluationSerializer < SimpleDelegator
  attr_reader :evaluation

  def initialize(evaluation=nil)
    @evaluation = evaluation
    __setobj__(evaluation)
  end

  def self.wrap(collection)
    collection.map do |obj|
      new(obj).serialized_json
    end
  end

  def grades
    GradeSerializer.wrap(evaluation.grades)
  rescue
    []
  end

  def title
    evaluation.title
  rescue
    ''
  end

  def weighted_score
    evaluation.weighted_score.round(2)
  rescue
    0
  end

  def serialized_json
    {
      titulo: title,
      media_ponderada: weighted_score,
      notas: [
        grades
      ]
    }
  end
end