#This migration is adding a table called 'messages' 
class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
		t.string :text #creates a string column called 'text'
		t.references :chat, index: true, foreign_key: true #'t.references: chat, index: true' will create a chat_id column in the messages table. It will 
		#also create a non-unique index on the 'chat_id' column, named 'chat_messages_on_chat_id'. index: true' adds a database index to the reference column. 
		#'foreign_key' is a foregin key name from a chat name.
		t.timestamps #the timestamp column created_at and updated_at which Active Record populates automatically will be added.
    end
  end
end
