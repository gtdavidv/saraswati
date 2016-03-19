#The migration is adding a table called 'chats' 
class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
		t.timestamps #the timestamp column created_at and updated_at which Active Record populates automatically will be added.
    end
  end
end
