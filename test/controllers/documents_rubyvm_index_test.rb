require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  test "index" do
    get :index
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsControllerTest, 'test_index')

# ruby -Ilib:test test/controllers/documents_rubyvm_index_test.rb
puts RubyVM.stat
Minitest.run_one_method(DocumentsControllerTest, 'test_index')
puts RubyVM.stat
