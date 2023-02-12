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

class SignalStrengths
  private attr_reader :registers, :multipliers

  def initialize(registers, multipliers)
    @registers = registers
    @multipliers = multipliers
  end

  def self.to_a(...)
    self.new(...).to_a
  end

  def to_a
    multipliers.map { |m| m * registers[m-1] }
  end
end



class Answer
  def initialize(inputs)
    @inputs = inputs
    @modified_inputs = @inputs.map { |i| InstructionIntegerizer.to_a(i)}.flatten
    @register_values = CPU.new(@modified_inputs).results
  end

  def part_one
    SignalStrengths.to_a(@register_values, [20, 60, 100, 140, 180, 220]).sum
  end

  def part_two
    array = PixelMapper.to_pixel_map(@register_values)
    p array.slice(0, 40).join
    p array.slice(40, 40).join
    p array.slice(80, 40).join
    p array.slice(120, 40).join
    p array.slice(160, 40).join
    p array.slice(200, 40).join
  end
end

class PixelMapper
  private attr_reader :registers

  def initialize(registers)
    @registers = registers
  end

  def self.to_pixel_map(...)
    self.new(...).pixelize
  end

  def pixelize
    @registers.map.with_index do |value, index|
      ((value - 1)..(value + 1)).include?(index%40) ? "#" : "."
    end
  end
end


class CPU
  def initialize(instructions)
    @instructions = instructions
  end

  def results
    array = [1]
    @instructions.each do |i|
      array << array.last + i
    end
    array
  end
end

class InstructionIntegerizer
  def initialize(instruction)
    @instruction = instruction
  end

  def self.to_a(...)
    self.new(...).to_a
  end

  def to_a
    split.map(&:to_i)
  end

  private

  def split
    @instruction.split(' ')
  end
end



answer = Answer.new(FileReader.new('input.txt').output)
p answer.part_one
answer.part_two