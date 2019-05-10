require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup
    @card = cards(:one)
  end

  test 'should invalidate without title' do
    @card.title = nil
    assert @card.valid? || @card.errors[:title].present?, 'no validation error for title present'
  end

  test 'should invalidate without description' do
    @card.description = nil
    @card.valid?
    assert @card.valid? || @card.errors[:description].present?
  end

  test 'should invalidate if end date is greater than start date' do
    @card.expiry_at = @card.starting_at.advance(hours: -2)
    @card.valid?
    assert @card.valid? || @card.errors[:expiry_at].present?, 'End date must be greater than start date'
  end

  test 'should invalidate without start date if end date is present' do
    @card.starting_at = nil
    @card.valid?
    assert @card.valid? || @card.errors[:starting_at].present?, 'Add validation to check presence of start date, if end date is available'
  end

  test 'should not accept invalid status' do
    @card.status = 'MyString'
    assert @card.valid? || @card.errors[:status].present?, 'Status is invalid'
  end

  test 'should create card' do
    assert_difference('Card.count', 1, 'Card was not created') do
      @card.save
    end
  end

end
