class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_card
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_url, notice: 'Comment was successfully destroyed.'
  end

  private
    def set_card
      @card = current_user.cards.find(params[:card_id])
    end

    def set_comment
      @comment = @card.comments.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end
