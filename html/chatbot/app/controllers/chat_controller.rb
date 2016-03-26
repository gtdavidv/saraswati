class ChatController < ApplicationController
	include NlqProcessor #Separate file in the lib folder that contains the code for processing queries
	
	before_filter :authorize

	def index
		if !(defined? session[:chat_id]) || !session[:chat_id]
			@chat = Chat.create
			session[:chat_id] = @chat.id
		#else
			#@chat = Chat.find_by_id(session[:chat_id])
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
