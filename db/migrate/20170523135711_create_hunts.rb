class CreateHunts < ActiveRecord::Migration[5.0]
  def change
    create_table :hunts do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :city
      t.float :distance
      t.integer :difficulty

      t.timestamps
    end
  end
end
