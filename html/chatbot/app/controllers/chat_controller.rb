class ChatController < ApplicationController
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
		@message2 = @chat.messages.new(text: 'Hi!', bot_message: true)
		@message2.save!
		redirect_to chat_path
	end

	private
  		def message_params
    		params.require(:message).permit(:text)
  		end
end
