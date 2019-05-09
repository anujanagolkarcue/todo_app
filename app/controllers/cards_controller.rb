class CardsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_board
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = Card.new(card_params)

    if @card.save
      redirect_to @card, notice: 'Card was successfully created.'
    else
      render :new
    end
  end

  def update
    if @card.update(card_params)
      redirect_to @card, notice: 'Card was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_url, notice: 'Card was successfully destroyed.'
  end

  private
    def set_card
      @board = current_user.boards.find(params[:id])
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
