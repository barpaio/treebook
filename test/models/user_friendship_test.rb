require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:friend)
  test "that creating a friendship works w/o raising exception" do 
  	assert_nothing_raised do
  		UserFriendship.create user: users(:ally), friend: users(:brian)
  	end
  end

  test "that creating a friendship based on user id and friend id works" do
		UserFriendship.create user_id: users(:brian).id, friend_id: users(:mom).id
		assert users(:brian).friends.include?(users(:mom))
	end
end
