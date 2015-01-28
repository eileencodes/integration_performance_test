require 'test_helper'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')

# ruby -Ilib:test test/integration/documents_stackprof_index_test.rb
result = RubyProf.profile do
  Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
end

File.open('graphs/including_minitest/index_integration_callstack.html', 'w') do |file|
  RubyProf::CallStackPrinter.new(result).print(file)
end

File.open('graphs/including_minitest/index_integration_html_graph.html', 'w') do |file|
  RubyProf::GraphHtmlPrinter.new(result).print(file)
end
