class GamesController < ApplicationController
  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
  end

  def create
    @game = Game.new(params[:game].permit(:name, :grid_size))
    if @game.save
      redirect_to root_path
    else
      render action: :new
    end
  end
end
