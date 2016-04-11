class NodesController < ApplicationController
	
	before_filter :authorize

	def index
		@nodes = Node.all
	end

	def show
		@node = Node.find(params[:id])
		@relationships = Relationship.where('node_a_id=? OR node_b_id=?', @node.id, @node.id)
		
		@nuggetArray = []
		@relationships.each do |relationship|
			node2 = nil
			if relationship.node_a_id == @node.id
				node2 = Node.find(relationship.node_b_id)
			else
				node2 = Node.find(relationship.node_a_id)
			end
			@nuggetArray[relationship.id] = node2.nugget
		end
	end

	def new
		@node = Node.new
	end

	def edit
		@node = Node.find(params[:id])
	end

	def create
		@node = Node.new(node_params)

		if @node.save
			redirect_to nodes_path
		else
			render 'new'
		end
	end
	
	def create_relationship
		@relationship = Relationship.new(node_a_id: params[:id], node_b_id: params[:relationship][:node_b_id], a_to_b_relationship: params[:relationship][:a_to_b_relationship], b_to_a_relationship: params[:relationship][:b_to_a_relationship])
		@relationship.save!
		
		redirect_to nodes_path + '/' + params[:id]
	end

	def update
  		@node = Node.find(params[:id])
 
  		if @node.update(node_params)
    		redirect_to nodes_path + '/' + @node.id.to_s
  		else
    		render 'edit'
  		end
	end

	def destroy
		@node = Node.find(params[:id])
		@node.destroy

		redirect_to nodes_path
	end
	
	def search
		@nodes = Node.where("nugget LIKE :search_string", {:search_string => "%#{params[:search]}%"}).limit(5)
		render :layout => 'blank'
	end

	private
  		def node_params
    		params.require(:node).permit(:nugget)
  		end
end
