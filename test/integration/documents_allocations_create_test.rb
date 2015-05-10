require 'test_helper'
require 'objspace'

class DocumentsIntegrationTest < ActionDispatch::IntegrationTest
  test "create" do
    post '/documents', params: { document: { title: "New things", content: "Doing them" } }

    document = Document.last
    assert_equal 'New things', document.title
    assert_equal 'Doing them', document.content
  end
end

ObjectSpace::AllocationTracer.setup(%i{path line type})
result = ObjectSpace::AllocationTracer.trace do
  3000.times do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_create')
  end
end
p allocated: ObjectSpace::AllocationTracer.allocated_count_table[:T_STRING]
result.sort_by { |info, counts| counts.first }.reverse.first(5).each do |r|
  p r
end
__END__
ObjectSpace::AllocationTracer.setup(%i{path line type})
result = ObjectSpace::AllocationTracer.trace do
  3000.times do
    Minitest.run_one_method(DocumentsIntegrationTest, 'test_create')
  end
end
result.sort_by { |info, counts| counts.first }.reverse.first(5).each do |r|
  p r
end
