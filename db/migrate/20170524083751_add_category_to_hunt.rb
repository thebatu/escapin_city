class AddCategoryToHunt < ActiveRecord::Migration[5.0]
  def change
    add_reference :hunts, :category, foreign_key: true
  end
end
