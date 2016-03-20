#This adds a column to the 'messages' table. Did this so didn't have to re-create the database table. 
class AddBotFlagToMessages < ActiveRecord::Migration
  def change
	add_column :messages, :bot_message, :boolean, :default => false #this adds a column in the table 'messages' that comes from the robot.
	#boolean is a binary variable that is either 'true' or 'false', in this case defaults to 'false'
  end
end