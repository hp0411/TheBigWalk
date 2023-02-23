class RenameResumes < ActiveRecord::Migration[7.0]
  def self.up
      rename_table :resumes, :checkpoints
  end
  def self.down
      rename_table :checkpoints, :resumes
  end
end
