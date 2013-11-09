class ChatroomsController < ApplicationController

	def create_room
		user_id = params[:id]
		room_name = params[:name]
		
		room = Chatroom.create({
			:name => room_name
		})
		
		ChatroomParticipant.create({
			:chatroom_id => room.id,
			:user_id => user_id
		})
		
		render :json=>{:success=>true, :name=>room_name, :id=>room.id, :count=>1}
	end
	
	
	def get_rooms
		data = []
		data.push({:id=>0, :name=>'Default room', :count=>User.where('updated_at > ?', Time.now - 10).count})
		rooms = Chatroom.all
		rooms.each do |room|
			count = get_participant_count(room.id)
			data.push({
				:id => room.id,
				:name => room.room_name,
				:count => count
			}) if (count > 0)
		end
		
		render :json=>{:success=>true, :msg=>data}
	end
	
	private
	def get_participant_count(chatroom_id)
		count = 0
		participants = ChatroomParticipant.where({:chatroom_id => chatroom_id})
		participants.each do |participant|
			user = User.find_by_id(participant.user_id)
			next if (user.nil?)
			count += 1 if (user.updated_at > (Time.now - 10))
		end
		
		return count
	end
end
