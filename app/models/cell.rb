class Cell < ActiveRecord::Base
  TIME_BETWEEN_TURNS = 20.hours

  belongs_to :game

  validate :not_within_cooldown

  def do_you_have_a_bomb?
    has_mine?
  end

  def mark_as_checked!
    self.check = true
    self.checked_at = Time.now
    save
  end

  def not_checked_yet
    !check
  end

  def neighbouring_mines_count
    neighbouring_cells.where(has_mine: true).count
  end

  private

  def not_within_cooldown
    if game
      latest_checked_at = game.latest_checked_at
      if latest_checked_at
        time_since_checked = Time.now - latest_checked_at
        if time_since_checked < TIME_BETWEEN_TURNS
          errors.add(:base, "You already had a go today")
        end

      end
    end
  end

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
