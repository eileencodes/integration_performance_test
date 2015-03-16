require 'test_helper'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  # standard test
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
