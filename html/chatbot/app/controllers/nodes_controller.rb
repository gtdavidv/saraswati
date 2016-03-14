class NodesController < ApplicationController
	def index
		@nodes = Node.all
	end

	def show
		@node = Node.find(params[:id])
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
			redirect_to '/nodes/'
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

		redirect_to '/nodes/'
	end

	private
  		def node_params
    		params.require(:node).permit(:nugget)
  		end
end
