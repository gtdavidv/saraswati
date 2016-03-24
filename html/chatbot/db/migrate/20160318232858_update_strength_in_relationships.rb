class UpdateStrengthInRelationships < ActiveRecord::Migration
  def change
	change_column :relationships, :strength, :decimal, :default => 0, :null => false
  end
end