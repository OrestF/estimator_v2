class ChangeSpecificationFields < ActiveRecord::Migration[6.0]
  def change
    change_column_null :specifications, :project_id, true
  end
end
