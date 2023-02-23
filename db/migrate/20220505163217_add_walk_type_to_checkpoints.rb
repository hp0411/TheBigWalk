class AddWalkTypeToCheckpoints < ActiveRecord::Migration[7.0]
  def change
    add_column :checkpoints, :walk_type, :integer
  end
end
