class Answer
  def initialize(inputs)
    @inputs = inputs
  end

  def part_one
    @zoo = Zoo.new(@inputs)
    @zoo.play_multiple_rounds(20)
    @counts = @zoo.inspect_counts.sort
    @counts[-1] * @counts[-2]
  end

  def part_two
    @zoo = Zoo.new(@inputs)
    @zoo.play_multiple_rounds(10000)
    @counts = @zoo.inspect_counts.sort
    @counts[-1] * @counts[-2]
  end
end


class Zoo
  def initialize(monkeys)
    @monkeys = monkeys
  end
  def inspect_counts
    @monkeys.map do |monkey|
      monkey.inspect_count
    end
  end

  def play_multiple_rounds(number)
    number.times do |i|
      play_round
    end
  end

  def play_round
    @monkeys.each do |monkey|
      monkey.play_round
    end
  end
end

class ZooData
  def initialize
    @monkey_0 = Monkey.new(
      items: [74, 64, 74, 63, 53],
      operation: Proc.new{ |x| x * 7 },
      conditional: Proc.new{ |x| x % 5 == 0 }
    )
    @monkey_1 = Monkey.new(
      items: [69, 99, 95, 62],
      operation: Proc.new{ |x| x * x },
      conditional: Proc.new{ |x| x % 17 == 0 }
    )
    @monkey_2 = Monkey.new(
      items: [59, 81],
      operation: Proc.new{ |x| x + 8 },
      conditional: Proc.new{ |x| x % 7 == 0 }
    )
    @monkey_3 = Monkey.new(
      items: [50, 67, 63, 57, 63, 83, 97],
      operation: Proc.new{ |x| x + 4 },
      conditional: Proc.new{ |x| x % 13 == 0 }
    )
    @monkey_4 = Monkey.new(
      items: [61, 94, 85, 52, 81, 90, 94, 70],
      operation: Proc.new{ |x| x + 3 },
      conditional: Proc.new{ |x| x % 19 == 0 }
    )
    @monkey_5 = Monkey.new(
      items: [69],
      operation: Proc.new{ |x| x + 5 },
      conditional: Proc.new{ |x| x % 3 == 0 }
    )
    @monkey_6 = Monkey.new(
      items: [54, 55, 58],
      operation: Proc.new{ |x| x + 7 },
      conditional: Proc.new{ |x| x % 11 == 0 }
    )
    @monkey_7 = Monkey.new(
      items: [79, 51, 83, 88, 93, 76],
      operation: Proc.new{ |x| x * 3 },
      conditional: Proc.new{ |x| x % 2 == 0 }
    )
    @monkey_0.set_true_and_false([@monkey_1, @monkey_6])
    @monkey_1.set_true_and_false([@monkey_2, @monkey_5])
    @monkey_2.set_true_and_false([@monkey_4, @monkey_3])
    @monkey_3.set_true_and_false([@monkey_0, @monkey_7])
    @monkey_4.set_true_and_false([@monkey_7, @monkey_3])
    @monkey_5.set_true_and_false([@monkey_4, @monkey_2])
    @monkey_6.set_true_and_false([@monkey_1, @monkey_5])
    @monkey_7.set_true_and_false([@monkey_0, @monkey_6])
  end

  def monkeys
    [@monkey_0, @monkey_1, @monkey_2, @monkey_3, @monkey_4, @monkey_5, @monkey_6, @monkey_7]
  end

end



class TestZooData
  def initialize
    @monkey_0 = Monkey.new(
      items: [79, 98],
      operation: Proc.new{|x| x * 19},
      conditional: Proc.new{|x| x % 23 == 0 }
    )
    @monkey_1 = Monkey.new(
      items: [54, 65, 75, 74],
      operation: Proc.new{|x| x + 6 },
      conditional: Proc.new{|x| x % 19 == 0 }
    )
    @monkey_2 = Monkey.new(
      items: [79, 60, 97],
      operation: Proc.new{|x| x * x},
      conditional: Proc.new{|x| x % 13 == 0 }
    )
    @monkey_3 = Monkey.new(
      items: [74],
      operation: Proc.new{|x| x + 3 },
      conditional: Proc.new{|x| x % 17 == 0 }
    )
    @monkey_0.set_true_and_false([@monkey_2, @monkey_3])
    @monkey_1.set_true_and_false([@monkey_2, @monkey_0])
    @monkey_2.set_true_and_false([@monkey_1, @monkey_3])
    @monkey_3.set_true_and_false([@monkey_0, @monkey_1])
  end

  def monkeys
    @monkeys = [@monkey_0, @monkey_1, @monkey_2, @monkey_3]
  end
end

class Monkey
  attr_reader :inspect_count
  def initialize(**options)
    @items = options.fetch(:items, [])
    @operation = options.fetch(:operation, Proc.new { |x| x })
    @conditional = options.fetch(:conditional, Proc.new { |x| x == x })
    @inspect_count = options.fetch(:inspect_count, 0)
  end

  def add_items(new_items)
    @items = @items + new_items
  end

  def set_true_and_false(monkeys)
    @true_monkey, @false_monkey = monkeys
  end

  def play_round
    inspect_items
    partition_items
    throw_items
  end

  private

  def inspect_items
    @inspect_count += @items.length
    @items = inspector.inspect(@items)
  end

  def partition_items
    @true_items, @false_items = partitioner.partition(@items)
  end

  def throw_items
    @true_monkey.add_items(@true_items)
    @false_monkey.add_items(@false_items)
    @items = []
  end

  def inspector
    @inspector ||= ItemInspector.new(@operation)
  end

  def partitioner
    @partitioner ||= ItemPartitioner.new(@conditional)
  end
end

class ItemPartitioner
  def initialize(conditional)
    @conditional = conditional
  end

  def partition(items)
    items.partition{|i| @conditional.call(i) }
  end
end

class ItemInspector
  def initialize(operation)
    @operation = operation
  end

  def inspect(items)
    items.map { |i| @operation.call(i) % 9699690 }
  end
end

# p Answer.new(ZooData.new.monkeys).part_one
p Answer.new(ZooData.new.monkeys).part_two

