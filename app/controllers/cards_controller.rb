class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [:new, :create]
  before_action :set_card, except: [:index, :new, :create]

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

  def status
    if @card.send("#{params[:status]}!")
      redirect_to @card, notice: "Card updated to #{@card.status}."
    else
      redirect_to @card, error: "Card was not updated to #{@card.status}."
    end
  end

  def destroy
    if @card.destroy
      redirect_to cards_url, notice: 'Card was successfully destroyed.'
    else
      flash[:error] = 'Cannot delete card.'
      redirect_to cards_url
    end
  end

  private
    def set_board
      @board = current_user.boards.find(params[:board_id])
    end

    def set_card
      @card = (@board.try(:cards) || Card).find(params[:id])
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
