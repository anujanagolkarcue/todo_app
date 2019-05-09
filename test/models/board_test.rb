require 'test_helper'

class BoardTest < ActiveSupport::TestCase

  def setup
    @board = boards(:one)
  end

  test 'invalid without title' do
    @board.title = nil
    refute @board.valid?, 'Saved board without a title'
    refute_empty @board.errors[:title], 'no validation error for title present'
  end

  test 'invalid without description' do
    @board.description = nil
    refute @board.valid?, 'Saved board without a description'
    assert_not_nil @board.errors[:description]
  end

end
