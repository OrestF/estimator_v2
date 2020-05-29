class AddExperienceLevelToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :experience_level, :integer, default: 0, null: false
  end
end
