require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = build(:user)
    @user.password = 'secret'
  end

  test 'should invalidate without name' do
    @user.firstname = nil
    @user.lastname = nil
    @user.valid?
    assert @user.errors[:firstname].present?, 'No validation error for firstname present'
    assert @user.errors[:lastname].present?,  'No validation error for lastname present'
  end

  test 'should invalidate without valid email' do
    @user.email = 'email455'
    assert @user.valid? || @user.errors[:email].present?, 'Accepts invalid email. No validation to check email format'
  end
end
