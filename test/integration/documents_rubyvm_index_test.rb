require 'test_helper'
ActiveSupport::Dependencies.constantize('DocumentsController')

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')

# ruby -Ilib:test test/integration/documents_rubyvm_index_test.rb
puts RubyVM.stat
Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
puts RubyVM.stat
