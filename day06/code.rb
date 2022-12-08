class FileReader
  def initialize(file)
    @file = file
    @output = []
  end

  def read_file
    File.foreach(@file) do |line|
      @output = prepare(line)
    end
  end

  def output
    read_file
    @output
  end

  def prepare(line)
    line.chomp.split("")
  end
end



class Answer
  def initialize(inputs)
    @inputs = inputs
  end

  def part_one
    i = 0
    until @inputs[i, 4].uniq.length == 4
      i += 1
    end
    i + 4
  end

  def part_two
    i = 0
    until @inputs[i, 14].uniq.length == 14
      i += 1
    end
    i + 14
  end
end

answer = Answer.new(FileReader.new('input.txt').output)
p answer.part_one
p answer.part_two