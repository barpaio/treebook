require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  setup do
    @status = statuses(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end

  test "should be redirected when not logged in" do
    get :new
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should render the new page when logged in" do
    sign_in users(:ally)
    get :new
    assert_response :success
  end

  test "should be logged in to post a status" do
    post :create, status: { content: "Hello" }
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should create status when logged in" do
    sign_in users(:ally)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content }
    end

    assert_redirected_to status_path(assigns(:status))
  end

  test "should create status for the current user when logged in" do
    sign_in users(:ally)
    assert_difference('Status.count') do
      post :create, status: { content: @status.content, user_id: users(:brian).id }
    end
    assert_redirected_to status_path(assigns(:status))
    assert_equal assigns(:status).user_id, users(:ally).id
  end

  test "should show status" do
    get :show, id: @status
    assert_response :success
  end

  test "should get redirected to login when trying to edit" do
    get :edit, id: @status
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should get edit when logged in" do
    sign_in users(:ally)
    get :edit, id: @status
    assert_response :success
  end

  test "should get redirected to login when trying to update" do
    patch :update, id: @status, status: {content: @status.content}
    assert_response :redirect
    assert_redirected_to new_user_session_path
  end

  test "should update status" do
    sign_in users(:ally)
    patch :update, id: @status, status: { content: @status.content }
    assert_redirected_to status_path(assigns(:status))
  end

  test "should destroy status" do
    assert_difference('Status.count', -1) do
      delete :destroy, id: @status
    end

    assert_redirected_to statuses_path
  end
end
