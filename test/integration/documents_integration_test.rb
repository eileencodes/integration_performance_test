require 'test_helper'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  # standard test
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end

  # ruby -I lib:test test/integration/documents_integration_test.rb -n test_index_rp
  test "index rp" do
    result = RubyProf.profile do
      get '/documents'
      assert_equal 200, response.status
    end
    File.open('graphs/inside_minitest/index_integration_callstack.html', 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end

    File.open('graphs/inside_minitest/index_integration_htmlgraph.html', 'w') do |file|
      RubyProf::GraphHtmlPrinter.new(result).print(file)
    end
  end

  # ruby -I lib:test test/integration/documents_integration_test.rb -n test_index_flame
  test "index flame" do
    Flamegraph.generate("graphs/inside_minitest/index_integration_flamegraph.html") do
      get '/documents'
      assert_equal 200, response.status
    end
  end

  # standard test
  test "create" do
    post '/documents', document: { title: "New things", content: "Doing them" }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end

  # ruby -I lib:test test/integration/documents_integration_test.rb -n test_create_rp
  test "create rp" do
    result = RubyProf.profile do
      post '/documents', document: { title: "New things", content: "Doing them" }

      document = Document.last
      assert_equal 'New things', document.title
      assert_equal 'Doing them', document.content
    end
    File.open('graphs/inside_minitest/create_integration_callstack.html', 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end

    File.open('graphs/inside_minitest/create_integration_htmlgraph.html', 'w') do |file|
      RubyProf::GraphHtmlPrinter.new(result).print(file)
    end
  end

  # ruby -I lib:test test/integration/documents_integration_test.rb -n test_create_flame
  test "create flame" do
    Flamegraph.generate("graphs/inside_minitest/create_integration_flamegraph.html") do
      post '/documents', document: { title: "New things", content: "Doing them" }

      document = Document.last
      assert_equal 'New things', document.title
      assert_equal 'Doing them', document.content
    end
  end
end
