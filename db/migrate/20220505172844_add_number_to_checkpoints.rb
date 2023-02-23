class AddNumberToCheckpoints < ActiveRecord::Migration[7.0]
  def change
    add_column :checkpoints, :number, :integer
  end
end
