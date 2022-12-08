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



class Answer
  def initialize(inputs)
    @inputs = inputs
  end

  def part_one

  end

  def part_two

  end
end

answer = Answer.new(FileReader.new('input.txt').output)
answer.part_one
answer.part_two