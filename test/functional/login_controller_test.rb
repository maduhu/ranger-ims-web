require 'test_helper'

class LoginControllerTest < ActionController::TestCase
  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get do" do
    get :do
    assert_response :success
  end

end
