class AddStatesToSpecifications < ActiveRecord::Migration[6.0]
  def change
    add_column :specifications, :state, :integer, default: 0, null: false
  end
end
