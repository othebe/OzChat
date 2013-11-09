class UsersController < ApplicationController
	def join
		handle = params[:handle]
		avatar = params[:avatar]
		
		user = User.create({
			:handle => handle,
			:avatar => avatar
		})
		
		base_id = 0
		message = Message.where('created_at > ?', Time.now).order('id DESC').last
		if (!message.nil?)
			base_id = message.id
		end
		
		base_id = Message.last.id if (Message.count > 0)
		base_id ||= 0
		
		
		render :json=>{:success=>true, :msg=>user.id, :base_id=>base_id}
	end
	
	
	def get_users
		users = User.where('updated_at > ?', Time.now - 10).order('id DESC')
		data = []
		users.each do |user|
			data.push({:id=>user.id, :avatar=>user.avatar, :handle=>user.handle})
		end
		
		render :json=>data
	end
	
	
	def keep_alive
		id = params[:id]
		user = User.find_by_id(id)
		user.updated_at = Time.now
		user.save
		render :json=>{:success=>true}
	end
	
	
	def get_location
		require 'open-uri'
		require 'json'
		
		ip = request[:remote_ip]
		ip ||= '128.54.36.76'
		puts ip
		uri = URI.parse('http://www.geoplugin.net/json.gp?ip='+ip)
		
		result = JSON.parse(open('http://www.geoplugin.net/json.gp?ip='+ip).read)
		render :json=>result
	end
end
