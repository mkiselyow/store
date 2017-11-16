require 'test_helper'

class UsefulArticlesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get useful_articles_index_url
    assert_response :success
  end

  test "should get show" do
    get useful_articles_show_url
    assert_response :success
  end

end
