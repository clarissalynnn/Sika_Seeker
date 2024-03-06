require "test_helper"

class LoadingControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get loading_show_url
    assert_response :success
  end
end
