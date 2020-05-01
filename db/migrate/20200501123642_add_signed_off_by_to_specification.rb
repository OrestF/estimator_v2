class AddSignedOffByToSpecification < ActiveRecord::Migration[6.0]
  def change
    add_column :specifications, :signed_off_by_id, :bigint, index: true
  end
end
