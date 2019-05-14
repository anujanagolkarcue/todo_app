require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = build(:comment)
  end

  test 'should invalidate without body' do
    @comment.body = nil
    @comment.valid?
    assert @comment.errors[:body].present?, 'No validation error for body present'
  end

  test 'should have valid user' do
    @comment.user_id = 1
    @comment.valid?
    assert @comment.errors[:user].present?, 'Accepts invalid user_id'
  end

  test 'should not save without card' do
    @comment.card_id = 1
    @comment.valid?
    assert @comment.errors[:card].present?, 'Accepts invalid card_id'
  end

  test 'should create comment' do
    assert_difference('Comment.count', 1, 'comment was not created') do
      @comment.save
    end
  end
end
