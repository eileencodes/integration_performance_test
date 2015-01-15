require 'test_helper'
require 'benchmark/ips'

class DocumentsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_equal 200, response.status
  end

  test "create" do
    post :create, document: { title: "New things", content: "Doing them" }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end
end

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end

  test "create" do
    post '/documents', document: { title: "New things", content: "Doing them" }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end
end

Benchmark.ips(5) do |bm|
  bm.report 'INDEX: Integration Test' do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
  end

  bm.report 'INDEX: Functional Test' do
    Minitest.run_one_method(DocumentsControllerTest, 'test_index')
  end

  bm.compare!
end

Benchmark.ips(5) do |bm|
  bm.report 'CREATE: Integration Test' do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_create')
  end

  bm.report 'CREATE: Functional Test' do
    Minitest.run_one_method(DocumentsControllerTest, 'test_create')
  end

  bm.compare!
end
