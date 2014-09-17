require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)
  test "that creating a friendship works w/o raising exception" do 
  	assert_nothing_raised do
  		UserFriendship.create user: users(:ally), friend: users(:brian)
  	end
  end
end
