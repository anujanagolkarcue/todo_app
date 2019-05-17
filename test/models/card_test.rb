require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup
    @card = build(:card)
  end

  test 'should invalidate without title' do
    @card.title = nil
    @card.valid?
    assert @card.errors[:title].present?, 'No validation error for title present'
  end

  test 'should invalidate without description' do
    @card.description = nil
    @card.valid?
    assert @card.errors[:description].present?, 'No validation error for description present'
  end

  test 'should invalidate if end date is greater than start date' do
    @card.expiry_at = @card.starting_at.advance(hours: -2)
    @card.valid?
    assert @card.errors[:expiry_at].present?, 'End date must be greater than start date'
  end

  test 'should invalidate without start date if end date is present' do
    @card.starting_at = nil
    @card.valid?
    assert @card.errors[:starting_at].present?, 'Add validation to check presence of start date, if end date is available'
  end

  test 'should not accept invalid status' do
    @card.status = 'MyString'
    @card.valid?
    assert @card.errors[:status].present?, 'Status is invalid'
  end

  test "should create card" do
    @card = build(:card)
    assert @card.save
  end

  test 'should destroy card' do
    @card.destroy
    assert Card.find_by_id(@card.id).blank?
  end

  test 'should not destroy card if comment is present' do
    @card.save
    @card.comments.create(attributes_for(:comment).merge(user_id: @card.user.id))
    assert !@card.destroy
  end

  test 'should not destroy card if status is not initialized' do
    @card.in_progress!
    assert !@card.destroy
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
    @card.send("#{event}!")
    assert @card.send("#{Card.events_with_transition_state[event]}?")
  end
end
