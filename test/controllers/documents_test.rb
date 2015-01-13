require 'test_helper'
require 'benchmark/ips'

class DocumentsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_equal 200, response.status
  end
end

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get documents_url
    assert_equal 200, response.status
  end

  test "index other" do
    get 'http://www.example.com/documents'
    assert_equal 200, response.status
  end
end

Benchmark.ips(5) do |bm|
  bm.report 'Integration Test' do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
  end

  bm.report 'Integration Test 2' do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_index_other')
  end

  bm.report 'Functional Test' do
    Minitest.run_one_method(DocumentsControllerTest, 'test_index')
  end

  bm.compare!
end
