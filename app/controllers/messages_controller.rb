class MessagesController < ApplicationController

	def send_msg
		user_id = params[:user_id]
		chatroom_id = params[:chatroom_id]
		message_type = params[:msg_type]
		message = params[:msg]
		
		msg = Message.create({
			:user_id => user_id,
			:chatroom_id => chatroom_id,
			:msg_type => message_type,
			:message => message
		})
		
		render :json=>{:success=>true}
	end
	
	
	def get_messages
		base_id = params[:base_id]
		messages = Message.where('id > ?', base_id).order('id DESC')
		
		data = []
		messages.each do |message|
			user = User.find_by_id(message.user_id)
			data.push({:message=>message.message.to_s, :id=>message.id, :handle=>user.handle, :type=>message.msg_type})
		end
		
		render :json=>{:success=>true, :msg=>data}
	end
	
	
	def messenger
		render :layout => false
	end
	
end
