class AddSignedOffAtToSpecifications < ActiveRecord::Migration[6.0]
  def change
    add_column :specifications, :signed_off_at, :datetime
  end
end
