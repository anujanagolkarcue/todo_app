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

end
