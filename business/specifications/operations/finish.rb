class Specifications::Operations::Finish < BaseOperation
  def call
    return validation_fail(args) unless mark_as_finished

    success(args)
  end

  private

  def mark_as_finished
    record.finished!
  end
end
