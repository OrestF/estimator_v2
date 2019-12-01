class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :description
      t.integer :kind, default: 0, null: false
      t.integer :state, default: 0, null: false
      t.references :commentable, polymorphic: true

      t.timestamps
    end
  end
end
