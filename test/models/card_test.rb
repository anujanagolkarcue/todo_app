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

  test 'expiry_at must be greater than starting date' do

  end
end
