require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsControllerTest, 'test_index')

# ruby -Ilib:test test/controllers/documents_stackprof_index_test.rb
StackProf.run(mode: :cpu, out: 'graphs/including_minitest/index_controller_stackprof.dump') do
  3000.times do
    Minitest.run_one_method(DocumentsControllerTest, 'test_index')
  end
end
