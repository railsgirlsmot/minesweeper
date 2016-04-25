class Game < ActiveRecord::Base
  has_many :cells

  after_create :build_cells

  def build_cells
    mine_chance = 10

    mine_x = rand(grid_size)
    mine_y = rand(grid_size)

    grid_size.times do |location_y|
      grid_size.times do |location_x|
        has_mine = (location_x == mine_x && location_y == mine_y)
        Cell.create(game: self, location_x: location_x, location_y: location_y, has_mine: has_mine)
      end
    end
  end

  def cell_at(x, y)
    cells.where(location_x: x, location_y: y).first
  end

  def latest_checked_at
    cells.maximum(:checked_at)
  end
end
