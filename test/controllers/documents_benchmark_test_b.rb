require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_equal 200, response.status
  end
end

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
Minitest.run_one_method(DocumentsControllerTest, 'test_index')
StackProf.run(mode: :cpu, out: 'stackprof.dump') do
  3000.times do
Minitest.run_one_method(DocumentsControllerTest, 'test_index')
  end
end
