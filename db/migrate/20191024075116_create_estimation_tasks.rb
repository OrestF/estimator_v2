class CreateEstimationTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :estimation_tasks do |t|
      t.references :estimation, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :optimistic
      t.integer :pessimistic

      t.timestamps
    end
  end
end
