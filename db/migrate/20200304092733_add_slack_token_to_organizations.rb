class AddSlackTokenToOrganizations < ActiveRecord::Migration[6.0]
  def change
    add_column :organizations, :slack_access_token, :string
  end
end
