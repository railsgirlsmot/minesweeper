class Cell < ActiveRecord::Base
  belongs_to :game

  def do_you_have_a_bomb?
    has_mine?
  end

  def mark_as_checked!
    self.check = true
    save!
  end

  def not_checked_yet
    !check
  end

  def neighbouring_mines_count
    neighbouring_cells.where(has_mine: true).count
  end

  private

  def neighbouring_cells
    x_range = coordinate_range(location_x)
    y_range = coordinate_range(location_y)
    game.cells.where(location_x: x_range, location_y: y_range).where("id != ?", id)
  end

  def coordinate_range(position)
    result = [position - 1, position, position + 1]
    result.reject do |number|
      number < 0 || number >= game.grid_size
    end
  end
end
