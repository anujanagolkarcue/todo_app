require 'test_helper'

class CardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @card = create(:card)
    sign_in(@card.user)
  end

  test "should get new" do
    board = @card.board
    @card = build(:card)
    get new_board_card_url(board)
    assert_response :success
  end

  test "should create card" do
    board = @card.board
    @card = build(:card)
    assert_difference('Card.count') do
      post board_cards_url(board), params: {card: attributes_for(:card)}
    end

    assert_redirected_to card_url(Card.last)
  end

  test "should show card" do
    get card_url(@card)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_url(@card)
    assert_response :success
  end

  test "should update card" do
    patch card_url(@card), params: {card: attributes_for(:card)}
    assert_redirected_to card_url(@card)
  end

  test 'should move to in progress state' do
    patch status_card_url(@card), params: {status: :in_progress}
    assert @card.reload.in_progress?, "Status was not updated to 'in_progress'"
  end

  test 'should move from held to in progress state' do
    @card.hold!
    patch status_card_url(@card), params: {status: :in_progress}
    assert @card.reload.in_progress?, "Status was not updated to 'in_progress'"
  end

  test 'should move from initialized to held state' do
    patch status_card_url(@card), params: {status: :hold}
    assert @card.reload.held?, "Status was not updated to 'held'"
  end

  test 'should move from in_progress to held state' do
    @card.in_progress!
    patch status_card_url(@card), params: {status: :hold}
    assert @card.reload.held?, "Status was not updated to 'held'"
  end

  test 'should move to approved state' do
    @card.update_attributes(status: :complete)
    patch status_card_url(@card), params: {status: :approve}
    assert @card.reload.approved?, "Status was not updated to 'approved'"
  end

  test 'should move to complete state' do
    @card.in_progress!
    patch status_card_url(@card), params: {status: :complete}
    assert @card.reload.complete?, "Status was not updated to 'complete'"
  end

  test 'should move to resolved state' do
    @card.update_attributes(status: :approved)
    patch status_card_url(@card), params: {status: :resolve}
    assert @card.reload.resolved?, "Status was not updated to 'resolved'"
  end

  test 'should move from initialized to archived state' do
    patch status_card_url(@card), params: {status: :archive}
    assert @card.reload.archived?, "Status was not updated to 'archived'"
  end

  test 'should move from in_progress to archived state' do
    @card.status = :in_progress
    patch status_card_url(@card), params: {status: :archive}
    assert @card.reload.archived?, "Status was not updated to 'archived'"
  end

  test 'should move from held to archived state' do
    @card.status = :held
    patch status_card_url(@card), params: {status: :archive}
    assert @card.reload.archived?, "Status was not updated to 'archived'"
  end
end
