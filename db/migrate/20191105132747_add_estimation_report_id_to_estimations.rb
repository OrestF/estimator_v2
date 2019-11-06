class AddEstimationReportIdToEstimations < ActiveRecord::Migration[6.0]
  def change
    add_reference :estimations, :estimation_report
    remove_reference :estimations, :project
  end
end
