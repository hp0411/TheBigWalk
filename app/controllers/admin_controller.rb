class AdminController < ApplicationController
  MAX_CHECKPOINT_DISTANCE_METERS = 20

  def index
    
  end

  private
  def checkin_params
    params.permit(:checkpoint, :participant_numbers, :latitude, :longitude)
  end
end