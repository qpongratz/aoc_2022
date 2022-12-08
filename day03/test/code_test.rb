require 'minitest/autorun'
require 'minitest/pride'
require_relative '../code'

class CodeTest < Minitest::Test
  def test_common_elements
    assert_equal 'a', BagReader.new('abcdefga').common_element
  end

  def test_character_to_integer_conversion
    assert_equal 1, CharacterConverter.new('a').translate
    assert_equal 52, CharacterConverter.new('Z').translate
    assert_equal 27, CharacterConverter.new('A').translate
    assert_equal 26, CharacterConverter.new('z').translate
  end

  def test_part_one_gives_expected_results
    test_array = ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg", "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"]
    assert_equal 157, Answer.new(test_array).part_one
  end

  def test_multibag_reader_common_element
    test_array = ["abcde", "sjdinba", "zappppp"]
    assert_equal "a", MultiBagReader.new(test_array).common_element
  end

  def test_bag_chunker
    test_array = Array.new(30, "b")
    assert_equal 10, BagChunker.new(test_array).chunked.size
  end

  def test_part_two_gives_expected_results
    test_array = ["vJrwpWtwJgWrhcsFMMfFFhFp", "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL", "PmmdzqPrVvPwwTWBwg", "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn", "ttgJtRGJQctTZtZT", "CrZsJsPPZsGzwwsLwLmpwMDw"]
    assert_equal 70, Answer.new(test_array).part_two
  end
end
