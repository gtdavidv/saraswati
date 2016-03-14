class Relationship < ActiveRecord::Base
	validates :node_a_id, presence: true
	validates :node_b_id, presence: true
	validates :a_to_b_relationship, presence: true
	validates :b_to_a_relationship, presence: true
	validates :strength, presence: true
end