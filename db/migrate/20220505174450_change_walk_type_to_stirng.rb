class ChangeWalkTypeToStirng < ActiveRecord::Migration[7.0]
  def change
    change_column :checkpoints, :walk_type, :string
  end
end
