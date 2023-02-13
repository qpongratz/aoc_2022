require 'minitest/autorun'
require 'minitest/pride'
require_relative 'code'

class CodeTest < Minitest::Test
  def test_item_inspector
    @operation = Proc.new{ |x| x * 3 }
    @inspector = ItemInspector.new(@operation)
    assert_equal [1, 2, 3], @inspector.inspect([1, 2, 3])
  end

  def test_item_partitioner
    @conditional = Proc.new{ |x| (x % 3) == 0 }
    @partitioner = ItemPartitioner.new(@conditional)
    assert_equal [[3], [1, 2]], @partitioner.partition([1, 2, 3])
  end

  def test_zoo_works
    @zoo = Zoo.new(TestZooData.new.monkeys)
    @zoo.play_multiple_rounds(20)
    assert_equal [101, 95, 7, 105], @zoo.inspect_counts
  end

  def test_part_one
    @answer = Answer.new(TestZooData.new.monkeys)
    assert_equal 10605, @answer.part_one
  end
end
