class CreateCheckpoints < ActiveRecord::Migration[5.0]
  def change
    create_table :checkpoints do |t|
      t.float :lat
      t.float :log
      t.text :content
      t.text :clue
      t.references :hunt, foreign_key: true

      t.timestamps
    end
  end
end
