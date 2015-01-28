require 'test_helper'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')

# ruby -Ilib:test test/integration/documents_stackprof_index_test.rb
StackProf.run(mode: :cpu, out: 'graphs/including_minitest/index_integration_stackprof.dump') do
  3000.times do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
  end
end
