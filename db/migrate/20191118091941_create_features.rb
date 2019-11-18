class CreateFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :features do |t|
      t.string :title
      t.text :description
      t.text :acceptance_criteria
      t.references :specification, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_reference :estimation_tasks, :feature
  end
end
