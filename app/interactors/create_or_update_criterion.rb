class CreateOrUpdateCriterion
  include Interactor

  def call
    raise 'peso não pode ser vazio!' if context.weight.blank?

    save_criterion
  rescue => e
    context.fail!(error: e.message)
  end

  private

  def criterion
    @criterion ||= Criterion.find_by(id: context.id)
  end

  def save_criterion
    if criterion.blank?
      @criterion = Criterion.create(weight: context.weight)
    else
      criterion.update_attribute('weight', context.weight)

      UpdateScores.call(criterion: criterion)
    end

    context.criterion = criterion
  end
end