class EstimationReports::Operations::Create < BaseOperation
  def call
    estimator_ids

    build_record
    build_form
    return validation_fail unless form_valid?

    return validation_fail unless save_record

    create_estimations

    success(args.merge!(record: record))
  end

  private

  def create_estimations
    record.organization.users.where(id: estimator_ids).each do |estimator|
      Estimations::Operations::Create.call(record_params: { title: "#{record.title} - #{estimator.email}",
                                                                        user_id: estimator.id,
                                                                        estimation_report: record  })
    end
  end

  def build_record
    @record = EstimationReport.new(record_params.except(:estimator_ids))
  end

  def estimator_ids
    @estimator_ids ||= record_params.delete(:estimator_ids)
  end

  def form_class
    EstimationReports::Forms::Base
  end
end
