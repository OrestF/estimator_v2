class AddActiveToEstimations < ActiveRecord::Migration[6.0]
  def change
    add_column :estimations, :active, :boolean, default: true
    add_index :estimations, :active
  end
end
