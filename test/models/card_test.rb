require 'test_helper'

class CardTest < ActiveSupport::TestCase
  def setup
    @card = cards(:one)
    puts '', @card.inspect
  end

  test 'invalid without title' do
    @card.title = nil
    refute @card.valid?, 'Saved card without a title'
    refute_empty @card.errors[:title], 'no validation error for title present'
  end

  test 'invalid without description' do
    @card.description = nil
    refute @card.valid?, 'Saved card without a description'
    assert_not_nil @card.errors[:description]
  end

  test 'end date must be greater than starting date' do
    @card.expiry_at = @card.starting_at.advance(hours: -2)
    assert @card.expiry_at > @card.starting_at, 'End date must be greater than start date'
  end

  test 'invalid without start date if end date is present' do
    @card.starting_at = nil
    assert @card.starting_at?, 'Add validation to check start date is present if end date is available'
  end
end
