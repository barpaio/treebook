require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context "#new" do  
  	context "when not logged in" do
  		should "redirect to the login page" do
  			get :new
  			assert_response :redirect
  		end
  	end
  	context "when logged in" do
  		setup do
  			sign_in users(:brian)
  		end
  		should "get new and return success" do
  			get :new
  			assert_response :success
  		end
  		should "set flash error if no friend_id" do
  			get :new, {}
  			assert_equal "Friend required", flash[:error]
  		end
  		should "display the friend's name" do
  			get :new, friend_id: users(:ally) 
  			assert_match /#{users(:ally).full_name}/, response.body
  		end
  		should "assign a new user friendship" do
  			get :new, friend_id: users(:ally)
  			assert assigns(:user_friendship)
  		end
  		should "successfully assign a new user friendship" do
  			get :new, friend_id: users(:ally)
  			assert_equal users(:ally), assigns(:user_friendship).friend
  		end
      should "successfully assign a new user friendship to the currently logged in user" do
        get :new, friend_id: users(:ally)
        assert_equal users(:brian), assigns(:user_friendship).user
      end
      should "return 404 status if friend not found" do
        get :new, friend_id: 'invalid'
        assert_response :not_found
      end
      should "ask if you really want to request friendship" do
      	get :new, friend_id: users(:ally)
      	assert_match /Do you really want to friend #{users(:ally).full_name}?/, response.body
      end
  	end
  end
end
