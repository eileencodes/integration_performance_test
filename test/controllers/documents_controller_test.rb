require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  test "creating a new document" do
    post :create, document: { title: "New things", content: "Doing them" }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end
end
