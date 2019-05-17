require 'test_helper'

class BoardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @board = create(:board)
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
    params = attributes_for(:board)
    post boards_url, params: {board: params}
    board = Board.find_by(params)
    assert board.present?
    assert_redirected_to board_url(board)
  end

  test 'should not create board with invalid data' do
    params = @board.slice(:title, :description)
    post boards_url, params: {board: params}
    assert Board.where(params).count, 1
  end

  test "should show board" do
    get board_url(@board)
    assert_response :success
  end

  test "should get edit" do
    get edit_board_url(@board)
    assert_response :success
  end

  test "should update board" do
    params = {title: 'New Title', description: 'New description'}.with_indifferent_access
    patch board_url(@board), params: {board: params}
    assert_equal params, @board.reload.slice(:title, :description)
    assert_redirected_to board_url(@board)
  end

  test 'should not update board with invalid data' do
    new_board = create(:board, user: @board.user)
    patch board_url(new_board), params: {board: @board.slice(:title, :description)}
    assert new_board, new_board.reload
  end

  test "should destroy board" do
    delete board_url(@board)
    assert_redirected_to boards_url
    assert_equal flash[:notice], 'Board was successfully destroyed.'
  end

  test "should not destroy board if cards exists" do
    create(:card, board: @board)
    delete board_url(@board)
    assert_redirected_to boards_url
    assert_equal flash[:error], 'Cannot delete while cards exists.'
  end
end
