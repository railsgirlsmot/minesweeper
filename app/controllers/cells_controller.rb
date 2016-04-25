class CellsController < ApplicationController
  def sweep
    @cell = Cell.find(params[:id])
    @cell.mark_as_checked!

    if !@cell.valid?
      @cell.errors[:base].each do |error|
        flash[:error] = error
      end
    end

    redirect_to @cell.game
  end
end