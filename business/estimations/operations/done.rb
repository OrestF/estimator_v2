class Estimations::Operations::Done < BaseOperation
  def call
    return validation_fail(args) unless mark_as_done

    success(args)
  end

  private

  def mark_as_done
    record.done!
  end
end
