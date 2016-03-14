class Node < ActiveRecord::Base
	validates :nugget, presence: true
end