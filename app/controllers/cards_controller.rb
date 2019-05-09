class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = @board.cards
  end

  def show
  end

  def new
    @card = @board.cards.new
  end

  def edit
  end

  def create
    @card = @board.cards.new(card_params)

    if @card.save
      redirect_to @board, notice: 'Card was successfully created.'
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @board, notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  private
    def set_board
      @board = current_user.boards.find(params[:board_id])
    end

    def set_card
      @card = @board.cards.find(params[:id])
    end

    def card_params
      params.fetch(:card, {}).permit(
        :title,
        :description,
        :starting_at,
        :expiry_at,
        :reminder_at,
        :reminder_description
      )
    end
end
