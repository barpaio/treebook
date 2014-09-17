require 'test_helper'

class UserTest < ActiveSupport::TestCase
	should have_many(:user_friendships)
	should have_many(:friends)
	test "a user should enter a first name" do
		user = User.new
		assert !user.save
		assert !user.errors[:first_name].empty?
	end

	test "a user should enter a last name" do
		user=User.new
		assert !user.save
		assert !user.errors[:last_name].empty?
	end

	test "a user should enter a profile name" do
		user = User.new
		assert !user.save
		assert !user.errors[:profile_name].empty?
	end

	test " a user should have a unique profile name" do
		user = User.new
		user.profile_name = users(:ally).profile_name
		assert !user.save
		puts user.errors.inspect
		assert !user.errors[:profile_name].empty?
	end

	test "a user should have a profile name without spaces" do
		user = User.new
		user.profile_name = "My Profile With Spaces"
		assert !user.save
		assert !user.errors[:profile_name].empty?
		assert user.errors[:profile_name].include?("Must be formatted correctly.")
	end

	test "a user can have a correctly formatted profile name" do
		user = User.new(first_name: 'Jason', last_name: 'Seifer', email: 'jason2@teamtreehouse.com')
		user.password = user.password_confirmation = 'password'
		user.profile_name = 'jasonseifer_1'
		assert user.valid?
	end

	test "that no error is raised when trying to access friend list" do
		assert_nothing_raised do
			users(:brian).friends
		end
	end

	test "that creating friendships on a user works" do
		users(:brian).friends << users(:mom)
		users(:brian).friends.reload
		assert users(:brian).friends.include?(users(:mom))
	end

	test "that creating a friendship based on user id and friend id works" do
		UserFriendship.create user_id: users(:brian).id, friend_id: users(:mom).id
		assert users(:brian).friends.include?(users(:mom))
	end
end