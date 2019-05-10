require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  def setup
    @board = boards(:one)
  end

  test 'should invalidate without title' do
    @board.title = nil
    assert @board.valid? || @board.errors[:title], 'no validation error for title present'
  end

  test 'should invalidate without description' do
    @board.description = nil
    assert @board.valid? || @board.errors[:description], 'no validation error for description present'
  end

end
