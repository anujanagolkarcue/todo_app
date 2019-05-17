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
    params = attributes_for(:card)
    post board_cards_url(@card.board), params: {card: params}
    card = @card.board.cards.find_by(params.slice(:title, :description))
    assert card.present?
    assert_redirected_to card_url(card)
  end

  test 'should not create card with invalid data' do
    params = @card.slice(:title, :description)
    post board_cards_url(@card.board), params: {card: params}
    assert Card.where(params).count, 1
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
    params = {title: 'New Title', description: 'New description'}.with_indifferent_access
    patch card_url(@card), params: {card: params}
    assert_equal params, @card.reload.slice(:title, :description)
    assert_redirected_to card_url(@card)
  end

  test 'should not update card with invalid data' do
    new_card = create(:card, user: @card.user)
    patch card_url(new_card), params: {card: @card.slice(:title, :description)}
    assert new_card, new_card.reload
  end

  test 'should move from initialized to in progress state' do
    update_status(:in_progress)
  end

  test 'should move from held to in progress state' do
    update_status(:hold, [:in_progress])
  end

  test 'should move from initialized to held state' do
    update_status(:hold)
  end

  test 'should move from in_progress to held state' do
    update_status(:hold, [:in_progress])
  end

  test 'should move to approved state' do
    update_status(:approve, [:in_progress, :complete])
  end

  test 'should move to complete state' do
    update_status(:complete, [:in_progress])
  end

  test 'should move to resolved state' do
    update_status(:resolve, [:in_progress, :complete, :approve])
  end

  test 'should move from initialized to archived state' do
    update_status(:archive)
  end

  test 'should move from in_progress to archived state' do
    update_status(:archive, [:in_progress])
  end

  test 'should move from held to archived state' do
    update_status(:archive, [:hold])
  end

  def update_status(event, initial_events = [])
    initial_events.each { |ie| @card.send("#{ie}!") }
    patch status_card_url(@card), params: {status: event}
    assert_equal flash[:notice], "Card updated to #{Card.events_with_transition_state[event]}."
  end
end
