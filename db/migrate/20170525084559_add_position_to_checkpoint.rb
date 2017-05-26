class AddPositionToCheckpoint < ActiveRecord::Migration[5.0]
  def change
    add_column :checkpoints, :position, :integer
  end
end
