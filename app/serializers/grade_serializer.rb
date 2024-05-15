class GradeSerializer < SimpleDelegator
  attr_reader :grade

  def initialize(grade=nil)
    @grade = grade
    __setobj__(grade)
  end

  def self.wrap(collection)
    collection.map do  |obj|
      new(obj).serialized_json
    end
  end

  def score
    grade.score.round(2)
  end

  def criterion_weight
    grade.criterion.weight
  end

  def serialized_json
    {
      nota: score,
      criterio: {
        peso: criterion_weight
      }
    }
  end
end