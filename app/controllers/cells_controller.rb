class CellsController < ApplicationController
  def sweep
    @cell = Cell.find(params[:id])
    @cell.mark_as_checked!
    # if @cell.do_you_have_a_bomb?
    # else
    # end

    redirect_to @cell.game
  end
end