class ProjectSerializer < SimpleDelegator
  attr_reader :project

  def initialize(project=nil)
    @project     = project
    __setobj__(project)
  end

  def self.wrap(collection)
    collection.map do |obj|
      new(obj).serialized_json
    end
  end

  def evaluations
    EvaluationSerializer.wrap(project.evaluations)
  rescue
    []
  end

  def name
    project.name
  end

  def total_score
    project.total_score.round(2)
  end

  def serialized_json
    {
      project: {
        nome: name,
        media_total: total_score,
        evaluations: [
          evaluations
        ]
      }
    }
  end
end