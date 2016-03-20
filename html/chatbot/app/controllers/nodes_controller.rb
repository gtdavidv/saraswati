class NodesController < ApplicationController
	def index
		@nodes = Node.all
	end

	def show
		@node = Node.find(params[:id])
		@relationships = Relationship.where('node_a_id=? OR node_b_id=?', @node.id, @node.id)
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

	def update
  		@node = Node.find(params[:id])
 
  		if @node.update(node_params)
    		redirect_to @node
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
	end

	private
  		def node_params
    		params.require(:node).permit(:nugget)
  		end
end
