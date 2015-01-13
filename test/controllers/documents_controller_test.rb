require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  test "creating a new document" do
    result = RubyProf.profile do
      post :create, document: { title: "New things", content: "Doing them" }
    end
    printer = RubyProf::GraphPrinter.new(result)
    printer.print(STDOUT, {})
    #post :create, document: { title: "New things", content: "Doing them" }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end

  test "index" do
    result = RubyProf.profile do
      get :index
    end
    printer = RubyProf::GraphPrinter.new(result)
    printer.print(STDOUT, {})

    assert_equal 200, response.status
  end
end
