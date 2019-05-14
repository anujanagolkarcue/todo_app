require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @board = build(:board)
    sign_in(@board.user)
  end

  test "should get index" do
    get boards_url
    assert_response :success
  end

  test "should get new" do
    get new_board_url
    assert_response :success
  end

  test "should create board" do
    assert_difference('Board.count') do
      post boards_url, params: {board: @board.slice(:title, :description)}
    end

    assert_redirected_to board_url(Board.last)
  end

  test "should show board" do
    @board.save
    get board_url(@board)
    assert_response :success
  end

  test "should get edit" do
    @board.save
    get edit_board_url(@board)
    assert_response :success
  end

  test "should update board" do
    @board.save
    params = {title: 'New Title', description: 'New description'}.with_indifferent_access
    patch board_url(@board), params: {board: params}
    assert_equal params, @board.reload.slice(:title, :description)
    assert_redirected_to board_url(@board)
  end

  test "should destroy board" do
    @board.save
    assert_difference('Board.count', -1) do
      delete board_url(@board)
    end

    assert_redirected_to boards_url
  end
end
