require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  test "create" do
    post :create, document: { title: "New things", content: "Doing them" }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end
end

Minitest.run_one_method(DocumentsControllerTest, 'test_create')

# ruby -Ilib:test test/controllers/documents_stackprof_create_test.rb
result = RubyProf.profile do
  Minitest.run_one_method(DocumentsControllerTest, 'test_create')
end

File.open('graphs/including_minitest/create_controller_callstack.html', 'w') do |file|
  RubyProf::CallStackPrinter.new(result).print(file)
end

File.open('graphs/including_minitest/create_controller_html_graph.html', 'w') do |file|
  RubyProf::GraphHtmlPrinter.new(result).print(file)
end
