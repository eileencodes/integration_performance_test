require 'test_helper'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "create" do
    post '/documents', document: { title: "New things", content: "Doing them" }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end
end

Minitest.run_one_method(DocumentsIntegrationTest, 'test_create')

# ruby -Ilib:test test/integration/documents_flamegraph_create_test.rb
Flamegraph.generate("graphs/including_minitest/create_integration_flamegraph.html") do
  Minitest.run_one_method(DocumentsIntegrationTest, 'test_create')
end
