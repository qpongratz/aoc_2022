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

array = FileReader.new('input.txt').output
sums = []
array.slice_when{ |i, j| j.empty? }.each { |a| sums << a.map(&:to_i).sum }
p sums.max
p sums.sort.slice(-3, 3).sum

