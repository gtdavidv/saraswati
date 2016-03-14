class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
		t.text :nugget
		
		t.timestamps
    end
  end
end
