class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
		t.integer :node_a_id
		t.integer :node_b_id
		t.string :a_to_b_relationship #if A is B's parent, this would read "parent"
		t.string :b_to_a_relationship #if A is B's parent, this would read "child"
		t.decimal :strength
	
		t.timestamps
    end
  end
end
