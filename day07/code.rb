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
    line.chomp.split(" ")
  end
end

class ElfFile < Struct.new(:size, :name)
end

class ElfDirectory
  attr_reader :name, :parent
  def initialize(name, parent)
    @name = name
    @parent = parent
    @children = []
    @files = []
  end

  def size_up
    [size] + (@children.map(&:size_up))
  end

  def size
    size_of_children + size_of_files
  end

  def find(name)
    @children.find { |element| element.name == name }
  end

  def add_directory(name)
    @children << ElfDirectory.new(name, self)
  end

  def add_file(size, name)
    @files << ElfFile.new(size, name)
  end

  private

  def size_of_children
    @children.map { |c| c.size }.sum
  end

  def size_of_files
    @files.map { |f| f.size }.sum
  end
end

class FileManager
  def initialize
    @root = ElfDirectory.new("/", nil)
    @pwd = @root
  end

  def size_up
    @root.size_up.flatten
  end

  def perform(instruction)
    if instruction.first == "$"
      move(instruction.last)
    elsif instruction.first == 'dir'
      create_directory(instruction.last)
    else
      create_file(instruction.first.to_i, instruction.last)
    end
  end

  private

  def move(destination)
    case destination
      when ".."
        @pwd = @pwd.parent
      when 'ls'
        @pwd = @pwd
      else
        @pwd = @pwd.find(destination)
      end
  end

  def create_directory(name)
    @pwd.add_directory(name) 
  end

  def create_file(size, name)
    @pwd.add_file(size, name)
  end
end

class Answer
  def initialize(inputs)
    @inputs = inputs
    @file_structure = FileManager.new
    @total_space = 70000000
    @needed_space = 30000000
    create_file_structure
  end

  def part_one
    file_sizes.keep_if { |e| e < 100000 }.sum
  end

  def part_two
    file_sizes.keep_if { |e| e >= delete_target}.sort.first
  end

  private

  def delete_target
    @needed_space - unused_space
  end

  def unused_space
    @unused_space ||= @total_space - used_space
  end

  def used_space
    @used_space ||= file_sizes.max
  end

  def file_sizes
    @file_structure.size_up
  end

  def create_file_structure
    @inputs.each { |input| @file_structure.perform(input) }
  end
end

answer = Answer.new(FileReader.new('input.txt').output)
p answer.part_one
p answer.part_two