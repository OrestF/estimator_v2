class AddFieldsToEstimationTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :estimation_tasks, :experience_level, :string
    add_column :estimation_tasks, :price_per_hour, :decimal, default: 0
    add_column :estimation_tasks, :min_price, :decimal, default: 0
    add_column :estimation_tasks, :max_price, :decimal, default: 0
  end
end
