class AddDescriptionToCheckpoint < ActiveRecord::Migration[5.0]
  def change
    add_column :checkpoints, :description, :string
  end
end
