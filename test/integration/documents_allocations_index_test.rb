require 'test_helper'
require 'objspace'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end
end

ObjectSpace.trace_object_allocations do
  3000.times do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
  end
end

__END__
ObjectSpace::AllocationTracer.setup(%i{path line type})
result = ObjectSpace::AllocationTracer.trace do
  3000.times do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
  end
end
result.sort_by { |info, counts| counts.first }.reverse.first(5).each do |r|
  p r
end
