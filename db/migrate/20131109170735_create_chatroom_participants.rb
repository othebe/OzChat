class CreateChatroomParticipants < ActiveRecord::Migration
  def change
    create_table :chatroom_participants do |t|
      t.integer :chatroom_id
      t.integer :user_id

      t.timestamps
    end
  end
end
