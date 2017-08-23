require 'test_helper'

class ExtraControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get extra_home_url
    assert_response :success
  end

end
