require "test_helper"

class StatesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get states_top_url
    assert_response :success
  end
end
