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

class BagReader
  def initialize(string)
    @string = string
  end

  def rucksacks
    @rucksacks ||= [@string[0, halfway].split(//), @string[-halfway, halfway].split(//)]
  end

  def halfway
    @string.length / 2
  end

  def common_element
    (rucksacks.first & rucksacks.last).first
  end
end

class MultiBagReader
  private attr_reader :bags
  def initialize(array)
    @bags = prepare(array)
  end

  def prepare(array)
    array.map { |string| string.split(//) }
  end

  def common_element
    (bags[0] & bags[1] & bags[2]).first
  end
end

class BagChunker
  def initialize(array)
    @array = array
  end

  def chunked
    chunked_array = []
    until @array.empty?
      chunked_array << @array.shift(3)
    end
    chunked_array
  end
end

class CharacterConverter
  def initialize(character)
    @character = character
  end

  def translate
    key.index(@character) + 1
  end

  def key
    ("a".."z").to_a + ("A".."Z").to_a
  end
end

class Answer
  def initialize(inputs)
    @inputs = inputs
  end

  def part_one
    @inputs.map {|input| BagReader.new(input).common_element }
           .map {|character| CharacterConverter.new(character).translate }
           .sum
  end

  def part_two
    BagChunker.new(@inputs).chunked
      .map{ |array| MultiBagReader.new(array).common_element }
      .map {|character| CharacterConverter.new(character).translate }
      .sum
  end
end

answer = Answer.new(FileReader.new('input.txt').output)
p answer.part_one
p answer.part_two