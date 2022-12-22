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

class Position < Struct.new(:x, :y)
  def eql?(other)
    self.x == other.x && self.y == other.y
  end

  def adjacent_to?(other)
    ((self.x - 1)..(self.x + 1)).include?(other.x) && 
      ((self.y - 1)..(self.y + 1)).include?(other.y)
  end

  def move_up
    self.y += 1
  end

  def move_left
    self.x -= 1
  end

  def move_right
    self.x += 1
  end

  def move_down
    self.y -= 1
  end
end

class Tail
  attr_reader :position
  def initialize
    @position = Position.new(0, 0)
    @head_position = nil
    @position_log = []
  end

  def position_count
    @position_log.uniq.length
  end

  def move_towards_head(head_position)
    @head_position = head_position
    determine_move unless adjacent_to_head? 
    log_position
  end

  def determine_move
    return move_orthogonal if orthogonal?
    move_diagonal
  end

  def move_orthogonal
    if @position.y == @head_position.y
      @position.x > @head_position.x ? @position.move_left : @position.move_right
    elsif @position.x == @head_position.x
      @position.y > @head_position.y ? @position.move_down : @position.move_up
    end
  end

  def orthogonal?
    @position.y == @head_position.y || @position.x == @head_position.x
  end

  def move_diagonal
    @position.x < @head_position.x ? @position.move_right : @position.move_left
    @position.y < @head_position.y ? @position.move_up : @position.move_down
  end

  def adjacent_to_head?
    @position.adjacent_to?(@head_position)
  end

  def log_position
    @position_log << [@position.x, @position.y]
  end
end

class Head
  attr_reader :position

  def initialize
    @position = Position.new(0, 0)
  end

  def move(direction)
    position.move_up if direction == "U"
    position.move_down if direction == "D"
    position.move_left if direction == "L"
    position.move_right if direction == "R"
  end
end

class Board
  def initialize(instructions)
    @instructions = prepare(instructions).flatten
    @head = Head.new
    @tail = Tail.new
  end

  def process
    @instructions.each do |instruction|
      @head.move(instruction)
      @tail.move_towards_head(@head.position)
    end

    @tail.position_count
  end

  def process_ten
    setup_tails
    @instructions.each do |instruction|
      @head.move(instruction)
      @tail_1.move_towards_head(@head.position)
      @tail_2.move_towards_head(@tail_1.position)
      @tail_3.move_towards_head(@tail_2.position)
      @tail_4.move_towards_head(@tail_3.position)
      @tail_5.move_towards_head(@tail_4.position)
      @tail_6.move_towards_head(@tail_5.position)
      @tail_7.move_towards_head(@tail_6.position)
      @tail_8.move_towards_head(@tail_7.position)
      @tail_9.move_towards_head(@tail_8.position)
    end
    @tail_9.position_count
  end

  def setup_tails
    @tail_1 = Tail.new
    @tail_2 = Tail.new
    @tail_3 = Tail.new
    @tail_4 = Tail.new
    @tail_5 = Tail.new
    @tail_6 = Tail.new
    @tail_7 = Tail.new
    @tail_8 = Tail.new
    @tail_9 = Tail.new
  end

  def prepare(instructions)
    instructions.map do |i|
      Array.new(i.split.last.to_i, i.split.first)
    end
  end

end

class Answer
  def initialize(inputs)
    @inputs = inputs
  end

  def part_one
    Board.new(@inputs).process
  end

  def part_two
    Board.new(@inputs).process_ten
  end
end

answer = Answer.new(FileReader.new('input.txt').output)
p answer.part_one
p answer.part_two