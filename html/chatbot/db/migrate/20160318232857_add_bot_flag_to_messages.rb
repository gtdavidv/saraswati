class AddBotFlagToMessages < ActiveRecord::Migration
  def change
	add_column :messages, :bot_message, :boolean, :default => false
  end
end
