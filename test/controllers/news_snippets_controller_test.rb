require "test_helper"

class NewsSnippetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get news_snippets_index_url
    assert_response :success
  end
end
