require 'test_helper'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "creating a new document" do
    post documents_url, document: { title: "New things", content: "Doing them" }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end
end
