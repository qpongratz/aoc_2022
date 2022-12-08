require 'minitest/autorun'
require 'minitest/pride'
require_relative 'code'

class CodeTest < Minitest::Test
  def test_part_one_gives_expected_results
    assert_equal 95437, Answer.new(prepared_input).part_one
  end

  def test_part_two_gives_expected_results
    assert_equal 24933642, Answer.new(prepared_input).part_two
  end

  private

  def prepared_input
    sample_input.map {|e| e.split(" ")}
  end

  def sample_input
    [
      "$ ls",
      "dir a",
      "14848514 b.txt",
      "8504156 c.dat",
      "dir d",
      "$ cd a",
      "$ ls",
      "dir e",
      "29116 f",
      "2557 g",
      "62596 h.lst",
      "$ cd e",
      "$ ls",
      "584 i",
      "$ cd ..",
      "$ cd ..",
      "$ cd d",
      "$ ls",
      "4060174 j",
      "8033020 d.log",
      "5626152 d.ext",
      "7214296 k"
    ]
  end
end
