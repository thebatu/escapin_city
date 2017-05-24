class AddCoordinatesToHunts < ActiveRecord::Migration[5.0]
  def change
    add_column :hunts, :latitude, :float
    add_column :hunts, :longitude, :float
  end
end
