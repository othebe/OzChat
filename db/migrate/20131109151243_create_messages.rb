class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :chatroom_id
      t.integer :user_id
      t.integer :msg_type, :default=>0
      t.string :message

      t.timestamps
    end
  end
end
