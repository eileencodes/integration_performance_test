require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsControllerTest, 'test_index')

# ruby -Ilib:test test/controllers/documents_flamegraph_index_test.rb
Flamegraph.generate("graphs/including_minitest/index_controller_flamegraph.html") do
  Minitest.run_one_method(DocumentsControllerTest, 'test_index')
end
