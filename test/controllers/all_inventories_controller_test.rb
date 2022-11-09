require "test_helper"

class AllInventoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get all_inventories_index_url
    assert_response :success
  end
end
