require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  # standard test
  test "index" do
    get :index
    assert_equal 200, response.status
  end

  # will create a call stack and html graph output
  # ruby -I lib:test test/controllers/documents_controller_test.rb -n test_index_rp
  test "index rp" do
    result = RubyProf.profile do
      get :index
      assert_equal 200, response.status
    end
    File.open('graphs/rails_only/index_controller_callstack.html', 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end

    File.open('graphs/rails_only/index_controller_htmlgraph.html', 'w') do |file|
      RubyProf::GraphHtmlPrinter.new(result).print(file)
    end
  end

  # ruby -I lib:test test/controllers/documents_controller_test.rb -n test_index_sp_cpu
  test "index sp cpu" do
    StackProf.run(mode: :cpu, out: 'graphs/rails_only/index_controller_stackprof_cpu.dump') do
      3000.times do
        get :index
        assert_equal 200, response.status
      end
    end
  end

  # ruby -I lib:test test/controllers/documents_controller_test.rb -n test_index_sp_wall
  test "index sp wall" do
    StackProf.run(mode: :wall, out: 'graphs/rails_only/index_controller_stackprof_wall.dump') do
      3000.times do
        get :index
        assert_equal 200, response.status
      end
    end
  end

  # ruby -I lib:test test/controllers/documents_controller_test.rb -n test_index_flame
  test "index flame" do
    Flamegraph.generate("graphs/rails_only/index_controller_flamegraph.html") do
      get :index
      assert_equal 200, response.status
    end
  end

  # standard test
  test "create" do
    post :create, params: { document: { title: "New things", content: "Doing them" } }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end

  # ruby -I lib:test test/controllers/documents_controller_test.rb -n test_create_rp
  test "create rp" do
    result = RubyProf.profile do
      post :create, params: { document: { title: "New things", content: "Doing them" } }

      document = Document.last
      assert_equal 'New things', document.title
      assert_equal 'Doing them', document.content
    end
    File.open('graphs/rails_only/create_controller_callstack.html', 'w') do |file|
      RubyProf::CallStackPrinter.new(result).print(file)
    end

    File.open('graphs/rails_only/create_controller_htmlgraph.html', 'w') do |file|
      RubyProf::GraphHtmlPrinter.new(result).print(file)
    end
  end

  # ruby -I lib:test test/controllers/documents_controller_test.rb -n test_create_sp_cpu
  test "create sp cpu" do
    StackProf.run(mode: :cpu, out: 'graphs/rails_only/create_controller_stackprof_cpu.dump') do
      3000.times do
        post :create, params: { document: { title: "New things", content: "Doing them" } }

        document = Document.last
        assert_equal 'New things', document.title
        assert_equal 'Doing them', document.content
      end
    end
  end

  # ruby -I lib:test test/controllers/documents_controller_test.rb -n test_create_sp_wall
  test "create sp wall" do
    StackProf.run(mode: :wall, out: 'graphs/rails_only/create_controller_stackprof_wall.dump') do
      3000.times do
        post :create, params: { document: { title: "New things", content: "Doing them" } }

        document = Document.last
        assert_equal 'New things', document.title
        assert_equal 'Doing them', document.content
      end
    end
  end
  # ruby -I lib:test test/controllers/documents_controller_test.rb -n test_create_flame
  test "create flame" do
    Flamegraph.generate("graphs/rails_only/create_controller_flamegraph.html") do
      post :create, params: { document: { title: "New things", content: "Doing them" } }

      document = Document.last
      assert_equal 'New things', document.title
      assert_equal 'Doing them', document.content
    end
  end
end
