require 'minitest/autorun'
require 'minitest/pride'
require_relative '../code'

class CodeTest < Minitest::Test
  def test_input_formatter_returns_ranges
    assert_equal [(22..77), (14..96)], InputFormatter.new("22-77,14-96").to_ranges
  end

  def test_input_formatter_returns_arrays
    assert_equal [[22, 77], [14, 96]], InputFormatter.new("22-77,14-96").to_arrays
  end

  def test_answer_gives_correct_part_one
    assert_equal 2, Answer.new(inputs).part_one
  end

  def test_answer_gives_correct_part_two
    assert_equal 4, Answer.new(inputs).part_two
  end


  private

  def inputs
    [
      "2-4,6-8",
      "2-3,4-5",
      "5-7,7-9",
      "2-8,3-7",
      "6-6,4-6",
      "2-6,4-8"
    ]
  end
end
