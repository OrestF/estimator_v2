class AddDomainToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :domain, :string
  end
end
