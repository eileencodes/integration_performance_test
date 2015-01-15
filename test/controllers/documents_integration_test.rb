require 'test_helper'
require 'flamegraph'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    result = RubyProf.profile do
      get '/documents'
      assert_equal 200, response.status
    end
    printer = RubyProf::GraphHtmlPrinter.new(result)
    printer.print(STDOUT, {})
  end

  test "index flame" do
    Flamegraph.generate("integration_index.html") do
      get '/documents'
      assert_equal 200, response.status
    end
  end

  test "create" do
    result = RubyProf.profile do
      post '/documents', document: { title: "New things", content: "Doing them" }

      document = Document.last
      assert_equal 'New things', document.title
      assert_equal 'Doing them', document.content
    end
    printer = RubyProf::GraphHtmlPrinter.new(result)
    printer.print(STDOUT, {})
  end

  test "create flame" do
    Flamegraph.generate("integration_create.html") do
      post '/documents', document: { title: "New things", content: "Doing them" }

      document = Document.last
      assert_equal 'New things', document.title
      assert_equal 'Doing them', document.content
    end
  end
end
