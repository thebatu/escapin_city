class AddPhotoToCheckpoint < ActiveRecord::Migration[5.0]
  def change
    add_column :checkpoints, :photo, :string
  end
end
