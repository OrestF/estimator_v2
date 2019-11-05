class CreateEstimationReports < ActiveRecord::Migration[6.0]
  def change
    create_table :estimation_reports do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.datetime :deadline

      t.timestamps
    end
  end
end
