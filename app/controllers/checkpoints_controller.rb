class CheckpointsController < ApplicationController
   def index
      @checkpoints = Checkpoint.order(:walk_type, :number)
   end
   
   def new
      @checkpoints = CheckpointsService.get_list_of_checkpoints(params[:walk_type] || "long")
      @checkpoint = Checkpoint.new
   end
   #Test
   def create
      @checkpoint = Checkpoint.new(checkpoint_params)

      if @checkpoint.save
         redirect_to checkpoints_path, notice: "The checkpoint #{@checkpoint.name} has been uploaded."
      else
         render "new"
      end
      
   end

   def edit
      @checkpoints = CheckpointsService.get_list_of_checkpoints(params[:walk_type] || "long")
      @checkpoint = Checkpoint.find(params[:id])
      render :edit
   end
   
   def update
      @checkpoint = Checkpoint.find(params[:id])
      if @checkpoint.update(checkpoint_params)
        redirect_to checkpoints_path, notice: 'Checkpoint has been successfully updated.'
      else
        render :edit
      end
   end  
   
   def destroy
      @checkpoint = Checkpoint.find(params[:id])
      @checkpoint.destroy
      redirect_to checkpoints_path, notice:  "The checkpoint #{@checkpoint.name} has been deleted."
   end

   def show
      @checkpointslong = Checkpoint.order(:walk_type, :number).first(21)
      @checkpointsshort = Checkpoint.order(:walk_type, :number).last(12)
   end
   
   private
      def checkpoint_params
      params.require(:checkpoint).permit(:name, :attachment, :description, :lon, :lat, :number, :walk_type)
   end
   
 end