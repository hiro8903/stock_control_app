require "test_helper"

class WithdrawsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get withdraws_index_url
    assert_response :success
  end

  test "should get show" do
    get withdraws_show_url
    assert_response :success
  end

  test "should get new" do
    get withdraws_new_url
    assert_response :success
  end

  test "should get edit" do
    get withdraws_edit_url
    assert_response :success
  end
end
