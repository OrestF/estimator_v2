class DropProjectUsers < ActiveRecord::Migration[6.0]
  def change
    drop_table :project_users
  end
end
