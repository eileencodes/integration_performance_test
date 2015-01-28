require 'test_helper'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')

# ruby -Ilib:test test/integration/documents_flamegraph_index_test.rb
Flamegraph.generate("graphs/including_minitest/index_integration_flamegraph.html") do
  Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
end
