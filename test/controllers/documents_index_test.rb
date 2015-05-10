require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  # standard test
  test "this index" do
    get :index
    assert_equal 200, response.status
  end
end
