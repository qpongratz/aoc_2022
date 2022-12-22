require 'minitest/autorun'
require 'minitest/pride'
require_relative 'code'

class CodeTest < Minitest::Test
  def test_part_one_gives_expected_results
    assert_equal 21, Answer.new(sample_input).part_one
  end

  def test_part_two_gives_expected_results
    assert_equal 8, Answer.new(sample_input).part_two
  end

  def test_forest_width
    assert_equal 5, ForestParser.new(sample_input).forest_width
  end

  def test_forest_height
    assert_equal 5, ForestParser.new(sample_input).forest_height
  end

  def sample_input
    ["30373", "25512", "65332", "33549", "35390"]
  end
end
