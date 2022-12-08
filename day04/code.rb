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

class InputFormatter
  def initialize(input)
    @input = input
  end
  
  def to_ranges
    to_arrays.map do |array|
      Range.new(array.first, array.last)
    end
  end

  def to_arrays
    @input.split(',').map do |half|
      half.split('-').map(&:to_i)
    end
  end
end

class Answer
  def initialize(inputs)
    @inputs = inputs
  end

  def part_one
    @inputs.map { |input| InputFormatter.new(input).to_ranges }
           .select { |e| e.first.cover?(e.last) || e.last.cover?(e.first) }
           .length
  end

  def part_two
    @inputs.map { |input| InputFormatter.new(input).to_ranges }
           .select { |e| e.first.to_a.intersect?(e.last.to_a) }
           .length
  end
end

answer = Answer.new(FileReader.new('input.txt').output)
# answer.part_one
p answer.part_two