require 'test_helper'
require 'objspace'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "index" do
    get '/documents'
    assert_equal 200, response.status
  end
end

Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')

ObjectSpace::AllocationTracer.setup(%i{path line type})
result = ObjectSpace::AllocationTracer.trace do
  3000.times do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
  end
end

p :TOTAL => ObjectSpace::AllocationTracer.allocated_count_table.values.inject(:+)

result.sort_by { |info, counts| counts.first }.find_all { |info, counts| info.last == :T_ARRAY}.each do |r|
  p r
end
__END__
result.sort_by { |info, counts| counts.first }.reverse.first(5).each do |r|
  p r
end
ObjectSpace::AllocationTracer.allocated_count_table.each do |k,v|
  p k => (v / 3000)
end

ObjectSpace.trace_object_allocations do
  3000.times do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_index')
  end
end

