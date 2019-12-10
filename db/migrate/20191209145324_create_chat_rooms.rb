class CreateChatRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_rooms do |t|
      t.string :name
      t.references :chatable, polymorphic: true
      t.text :user_ids, array: true, default: []

      t.timestamps
    end
  end
end
