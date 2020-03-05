class AddDomainToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :domain, :integer, default: 0, null: false
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
