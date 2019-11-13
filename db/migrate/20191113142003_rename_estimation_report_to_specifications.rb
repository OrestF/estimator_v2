class RenameEstimationReportToSpecifications < ActiveRecord::Migration[6.0]
  def change
    rename_table :estimation_reports, :specifications
    rename_column :estimations, :estimation_report_id, :specification_id
  end
end
