class AddDeletedAtToModels < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :deleted_at, :datetime, default: nil
    add_column :specifications, :deleted_at, :datetime, default: nil
    add_column :estimations, :deleted_at, :datetime, default: nil
    add_column :estimation_tasks, :deleted_at, :datetime, default: nil
    add_column :features, :deleted_at, :datetime, default: nil
  end
end
