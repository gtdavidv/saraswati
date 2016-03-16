class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
		t.string :text
		t.references :chat, index: true, foreign_key: true
		
		t.timestamps
    end
  end
end
