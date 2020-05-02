class Estimations::Operations::Delete < BaseOperation
  def call
    return response(:fail, args) unless delete_record

    success(args)
  end

  private

  def delete_record
    record.delete
  end
end
