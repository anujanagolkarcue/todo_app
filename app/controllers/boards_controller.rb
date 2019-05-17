class BoardsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_board, only: [:show, :edit, :update, :destroy]

  def index
    @boards = Board.all
  end

  def show
    @cards = @board.cards
  end

  def new
    @board = current_user.boards.new
  end

  def edit
  end

  def create
    @board = current_user.boards.new(board_params)

    if @board.save
      redirect_to @board, notice: 'Board was successfully created.'
    else
      render :new
    end
  end

  def update
    if @board.update(board_params)
      redirect_to @board, notice: 'Board was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @board.destroy
      redirect_to boards_url, notice: 'Board was successfully destroyed.'
    else
      flash[:error] = 'Cannot delete while cards exists.'
      redirect_to boards_url
    end
  end

  private
    def set_board
      @board = current_user.boards.find(params[:id])
    end

    def board_params
      params.fetch(:board, {}).permit(:title, :description)
    end
end
