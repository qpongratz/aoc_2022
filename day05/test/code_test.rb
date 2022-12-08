require 'minitest/autorun'
require 'minitest/pride'
require_relative '../code'

class CodeTest < Minitest::Test
  def test_part_one_gives_expected_results
    assert_equal "CMZ", Answer.new(sample_input, sample_crates).part_one
  end

  def test_part_two_gives_expected_results
    assert_equal "MCD", Answer.new(sample_input, sample_crates).part_two
  end

  def test_numbers
    assert_equal [1,2,1], InputParser.new("move 1 from 2 to 1").numbers
  end

  def test_input_parser_parses
    InputParser.new("move 10 from 29 to 100").parsed_input.tap { |i|
      assert_equal 10, i.amount
      assert_equal 29, i.from
      assert_equal 100, i.to
    }
  end

  private

  def sample_input
    [
    "move 1 from 2 to 1",
    "move 3 from 1 to 3",
    "move 2 from 2 to 1",
    "move 1 from 1 to 2",
    ]
  end

  def sample_crates
    [%w[Z N], %w[M C D], %w[P]]
  end
end

