class Game < ActiveRecord::Base
  has_many :cells

  def build_cells
    mine_chance = 10

    grid_size.times do |location_y|
      grid_size.times do |location_x|
        has_mine = (rand(10) == 0)
        Cell.create(game: self, location_x: location_x, location_y: location_y, has_mine: has_mine)
      end
    end
  end

  def cell_at(x, y)
    cells.where(location_x: x, location_y: y).first
  end
end
