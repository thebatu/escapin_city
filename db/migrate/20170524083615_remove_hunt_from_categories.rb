class RemoveHuntFromCategories < ActiveRecord::Migration[5.0]
  def change
    remove_reference :categories, :hunt, foreign_key: true
  end
end
