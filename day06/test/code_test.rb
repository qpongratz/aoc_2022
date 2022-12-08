require 'minitest/autorun'
require 'minitest/pride'
require_relative '../code'

class CodeTest < Minitest::Test
  def test_part_one_gives_expected_results
    assert_equal 5, Answer.new("bvwbjplbgvbhsrlpgdmjqwftvncz".split("")).part_one
  end

  def test_part_two_gives_expected_results
    assert_equal 19, Answer.new("mjqjpqmgbljsphdztnvjfqwrcgsmlb".split("")).part_two
  end
end
