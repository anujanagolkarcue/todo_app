require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @user.password = 'secret'
  end

  test 'invalid without name' do
    @user.firstname = nil
    @user.lastname = nil
    @user.valid?
    refute_empty (@user.errors[:firstname] || @user.errors[:lastname]) ,
		"No validation error for #{([:firstname, :lastname] - @user.errors.keys).join(', ')} present"
  end

  test 'invalid without valid email' do
    @user.email = 'email455'
    @user.valid?
    refute_empty @user.errors[:email], 'Accepts invalid email. No validation to check email format'
  end
end
