class RenameColumnDistanceinTableHuntstoMydistance < ActiveRecord::Migration[5.0]
  def change
    rename_column :hunts, :distance, :mydistance
  end
end
