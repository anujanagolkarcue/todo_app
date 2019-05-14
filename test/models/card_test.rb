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

  test 'should create card' do
    assert_difference('Card.count', 1, 'Card was not created') do
      @card.save
    end
  end
end
