#The migration adds a table called 'relationships' 
class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
		t.integer :node_a_id #creates an integer column called 'node a id'
		t.integer :node_b_id #creates an integer column called 'node b id'
		t.string :a_to_b_relationship #if A is B's parent, this would read "parent"
		t.string :b_to_a_relationship #if A is B's parent, this would read "child"
		t.decimal :strength #creating an integer column called 'strength' that will eventually measure the strength between nodes. 	
		t.timestamps #the timestamp column created_at and updated_at which Active Record populates automatically will be added.
    end
  end
end
