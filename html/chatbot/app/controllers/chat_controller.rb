class ChatController < ApplicationController
	include NlqProcessor #Separate file in the lib folder that contains the code for processing queries
	
	#before_filter :authorize

	def index
		if !(defined? session[:chat_id]) || !session[:chat_id]
			if !(defined? session[:user_id]) || !session[:user_id]
				@chat = Chat.create
			else
				if Chat.exists?(user_id: session[:user_id])
					@chat = Chat.where('user_id' => session[:user_id]).first
				else
					@chat = Chat.create(user_id: session[:user_id])
				end
			end
			session[:chat_id] = @chat.id
		else
			if defined? session[:user_id]
				if !Chat.exists?(user_id: session[:user_id])
					Chat.where('id' => session[:chat_id]).update_all('user_id' => session[:user_id])
				end
			end
		end
		
		@messages = Message.joins(:chat).where('chat_id' => session[:chat_id])	
	end
	
	def create
		@chat = Chat.find_by_id(session[:chat_id])
		@message = @chat.messages.new(message_params)
		@message.save!
		
		responseText = generate_response(params[:message][:text])
		@message2 = @chat.messages.new(text: responseText, bot_message: true)
		@message2.save!
		redirect_to chat_path
	end

	private
  		def message_params
    		params.require(:message).permit(:text)
  		end
end
