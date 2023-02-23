class CheckinController < ApplicationController
  MAX_CHECKPOINT_DISTANCE_METERS = 20

  def index
    @selected_checkpoint = params[:checkpoint]
    @errors = params[:errors] || []
    @success = params[:success]
    @checkpoints = CheckpointsService.get_list_of_checkpoints(params[:walk_type] || "long")
  end

  def show
  end

  def create
    @errors = []
    checkpoint = Checkpoint.where(name: checkin_params[:checkpoint], walk_type: params[:walk_type]).first

    if checkpoint
      distance = Haversine.distance(
        checkin_params[:latitude].to_f, 
        checkin_params[:longitude].to_f,
        checkpoint.lat,
        checkpoint.lon
      ).to_meters
    else
      @errors << "Please add this checkpoint to the app."
    end

    if (distance > MAX_CHECKPOINT_DISTANCE_METERS)
      @errors << "You are too far from the checkpoint. Distance to checkpoint: #{distance} meters."
    end

    if checkin_params[:checkpoint] && !checkin_params[:participant_numbers]
      
    else
      checkin_params[:participant_numbers].gsub(/ /, '').split(',').each do |participant_number|
        if true #(distance < MAX_CHECKPOINT_DISTANCE_METERS)
          CheckpointsService.checkin(checkpoint, participant_number.to_i)
        end

        
      end

      redirect_to(
        controller: 'checkin', 
        action: 'index', 
        participant_number: checkin_params[:participant_number], 
        checkpoint: checkin_params[:checkpoint],
        errors: @errors,
        success: @errors.length == 0 ? "Successfully checked in to checkpoint #{checkin_params[:checkpoint]}" : nil
      )
    end
  end

  def dropout
    if params["pickup"]
      SheetsService.update_cell_help(params["walker"], "Dropped out", "10", "Through dropout function", "Through dropout function", "nil", "nil")
    end

    result = SheetsService.dropout(params["walker"], params["walktype"])
    redirect_to(
      controller: 'checkin', 
      action: 'index', 
      errors: result.updated_cells == 1 ? nil : "error",
      success: result.updated_cells == 1 ? "Successfully dropped out" : result.updated_cells
    )
  end

  private
  def checkin_params
    params.permit(:checkpoint, :participant_numbers, :latitude, :longitude)
  end
end