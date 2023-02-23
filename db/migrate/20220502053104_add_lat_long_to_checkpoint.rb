class AddLatLongToCheckpoint < ActiveRecord::Migration[7.0]
  def change
    add_column :checkpoints, :lat, :float
    add_column :checkpoints, :lon, :float
  end
end
