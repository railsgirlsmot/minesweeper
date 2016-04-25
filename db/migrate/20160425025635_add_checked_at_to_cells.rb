class AddCheckedAtToCells < ActiveRecord::Migration
  def change
    add_column :cells, :checked_at, :datetime
  end
end
