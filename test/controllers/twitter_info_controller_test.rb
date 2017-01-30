require 'test_helper'

class TwitterInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get twitter_info_index_url
    assert_response :success
  end

end
