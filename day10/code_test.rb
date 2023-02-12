require 'minitest/autorun'
require 'minitest/pride'
require_relative 'code'

class CodeTest < Minitest::Test
  def setup
  end

  def test_cpu_results
    @cpu = CPU.new([0, 0, 3, 0, -5])
    assert_equal [1, 1, 1, 4, 4, -1], @cpu.results
  end

  def test_instruction_integerizer_on_noop
    assert_equal [0], InstructionIntegerizer.to_a("noop")
  end

  def test_instruction_integerizer_on_add
    assert_equal [0, 15], InstructionIntegerizer.to_a("addx 15")
  end

  def test_instruction_integerizer_on_negative
    assert_equal [0, -11], InstructionIntegerizer.to_a("addx -11")
  end

  def test_input_provides_correct_answer
    @answer = Answer.new(FileReader.new('test_input.txt').output).part_one
    assert_equal 13140, @answer
  end

end
