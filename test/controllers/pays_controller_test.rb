require 'test_helper'

class PaysControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pays_new_url
    assert_response :success
  end

  test "should get show" do
    get pays_show_url
    assert_response :success
  end

end
