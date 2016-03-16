class Message < ActiveRecord::Base
	belongs_to :chat
	validates :text, presence: true
end