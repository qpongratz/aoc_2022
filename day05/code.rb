class FileReader
  def initialize(file)
    @file = file
    @output = []
  end

  def read_file
    File.foreach(@file) do |line|
      @output << prepare(line)
    end
  end

  def output
    read_file
    @output
  end

  def prepare(line)
    line.chomp
  end
end

class InputParser
  def initialize(input)
    @input = input
  end

  def parsed_input
    Instructions.new(*numbers)
  end

  def numbers
    @input.gsub(/\D/, " ").split(" ").map(&:to_i)
  end
end

class Instructions < Struct.new(:amount, :from, :to)
end



class Answer
  def initialize(inputs, crates)
    @inputs = inputs
    @crates = crates
  end

  def parsed_inputs
    @parsed_inputs ||= @inputs.map { |input| InputParser.new(input).parsed_input}
  end

  def part_one
    parsed_inputs.each {|input| run_instructions(input) }
    top_elements
  end

  def part_two
    parsed_inputs.each {|input| run_better_instructions(input) }
    top_elements
  end

  def top_elements
    string = ""
    @crates.each {|stack| string.concat(stack.last) }
    string
  end

  def run_instructions(instruction)
    @crates[instruction.to - 1]
      .push(*@crates[instruction.from - 1].pop(instruction.amount).reverse)
  end

  def run_better_instructions(instruction)
    @crates[instruction.to - 1]
      .push(*@crates[instruction.from - 1].pop(instruction.amount))
  end
end

CRATES = [
  %w[Q S W C Z V F T],
  %w[Q R B],
  %w[B Z T Q P M S],
  %w[D V F R Q H],
  %w[J G L D B S T P],
  %w[W R T Z],
  %w[H Q M N S F R J],
  %w[R N F H W],
  %w[J Z T Q P R B]
]
p Answer.new(FileReader.new('input.txt').output, CRATES).part_two
