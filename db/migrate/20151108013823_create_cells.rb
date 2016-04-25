class CreateCells < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.integer :location_x
      t.integer :location_y
      t.integer :game_id
      t.boolean :has_mine
      t.boolean :check

      t.timestamps null: false
    end
  end
end
