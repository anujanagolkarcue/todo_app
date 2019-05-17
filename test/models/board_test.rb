require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  def setup
    @board = build(:board)
  end

  test 'should invalidate without title' do
    @board.title = nil
    @board.valid?
    assert @board.errors[:title], 'No validation error for title present'
  end

  test 'should invalidate without description' do
    @board.description = nil
    @board.valid?
    assert @board.errors[:description], 'No validation error for description present'
  end

  test "should create board" do
    assert @board.save
  end

  test 'should destroy board' do
    @board.save
    assert @board.destroy || Board.find_by_id(@board.id).blank?
  end

  test 'should not destroy board if comment is present' do
    @board.save
    @board.cards.create(attributes_for(:card))
    assert !@board.destroy
  end
end
