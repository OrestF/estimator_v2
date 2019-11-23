class AddClientToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :client_id, :integer, index: true
  end
end
