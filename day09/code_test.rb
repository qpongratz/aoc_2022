require 'minitest/autorun'
require 'minitest/pride'
require_relative 'code'

class CodeTest < Minitest::Test
  def test_part_one_gives_expected_results
    assert_equal 13, Answer.new(sample_input).part_one
  end

  def test_part_two_gives_expected_results
    assert_equal 1, Answer.new(sample_input).part_two
  end

  def test_part_two_with_alternate_instructions
    assert_equal 36, Answer.new(alternate_input).part_two
  end

  def sample_input
    ["R 4", "U 4", "L 3", "D 1", "R 4" "D 1", "L 5", "R 2"]
  end

  def alternate_input
    ["R 5", "U 8", "L 8", "D 3", "R 17", "D 10", "L 25", "U 20"]
  end
end
