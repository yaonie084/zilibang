require 'test_helper'

class NoticesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get error" do
    get :error
    assert_response :success
  end

end
