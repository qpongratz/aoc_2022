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

class ForestParser
  attr_reader :forest
  def initialize(forest)
    @forest = prepare(forest)
  end

  def scenic_tree_scores
    @forest.map.with_index do |forest_row, row|
      forest_row.map.with_index do |tree, column|
        (left_score(row, column) * right_score(row, column) * above_score(row, column) * below_score(row, column))
      end
    end
  end

  def left_score(row, column)
    return 0 if first_or_last_column?(column) || first_or_last_row?(row)

    tree = @forest[row][column]
    trees_left = []
    j = column - 1
    until j < 0
      trees_left << @forest[row][j]
      j -= 1
    end
    trees_left.slice_when {|i, j| i >= tree }.first.length
  end
  
  def right_score(row, column)
    return 0 if first_or_last_column?(column) || first_or_last_row?(row)

    tree = @forest[row][column]
    trees_right = []
    j = column + 1
    until j >= forest_width
      trees_right << @forest[row][j]
      j += 1
    end
    trees_right.slice_when {|i, j| i >= tree }.first.length
  end

  def above_score(row, column)
    return 0 if first_or_last_column?(column) || first_or_last_row?(row)

    tree = @forest[row][column]
    trees_above = []
    i = row - 1
    until i < 0
      trees_above << @forest[i][column]
      i -= 1
    end
    trees_above.slice_when {|i, j| i >= tree }.first.length
  end

  def below_score(row, column)
    return 0 if first_or_last_column?(column) || first_or_last_row?(row)

    tree = @forest[row][column]
    trees_below = []
    i = row + 1
    until i >= forest_height
      trees_below << @forest[i][column]
      i += 1
    end
    trees_below.slice_when {|i, j| i >= tree }.first.length
  end

  def visible_trees
    trees = []
    @forest.map.with_index do |forest_row, row|
      forest_row.map.with_index do |tree, column|
        trees << tree if visible?(row, column)
      end
    end
    trees
  end

  def forest_width
    @forest_width ||= @forest.first.length
  end

  def forest_height
    @forest_height ||= @forest.length
  end

  def visible?(row, column)
    return true if first_or_last_column?(column) || first_or_last_row?(row)

    visible_from_above?(row, column) || visible_from_below?(row, column) || visible_from_left?(row, column) || visible_from_right?(row, column)
  end

  def visible_from_above?(row, column)
    tree = @forest[row][column]
    trees_above = []
    i = row - 1
    until i < 0
      trees_above << @forest[i][column]
      i -= 1
    end
    trees_above.all? {|e| e < tree }
  end

  def visible_from_below?(row, column)
    tree = @forest[row][column]
    trees_below = []
    i = row + 1
    until i >= forest_height
      trees_below << @forest[i][column]
      i += 1
    end
    trees_below.all? {|e| e < tree }
  end

  def visible_from_left?(row, column)
    tree = @forest[row][column]
    trees_left = []
    j = column - 1
    until j < 0
      trees_left << @forest[row][j]
      j -= 1
    end
    trees_left.all? {|e| e < tree }
  end

  def visible_from_right?(row, column)
    tree = @forest[row][column]
    trees_right = []
    j = column + 1
    until j >= forest_width
      trees_right << @forest[row][j]
      j += 1
    end
    trees_right.all? {|e| e < tree }
  end

  def first_or_last_row?(row)
    (row == 0) || (row == forest_height - 1)
  end

  def first_or_last_column?(column)
    (column == 0) || (column == forest_height - 1)
  end

  private

  def prepare(forest)
    forest.map do |row|
      row.split('').map(&:to_i)
    end
  end
end



class Answer
  def initialize(inputs)
    @inputs = inputs
  end

  def part_one
    ForestParser.new(@inputs).visible_trees.count
  end

  def part_two
    ForestParser.new(@inputs).scenic_tree_scores.map(&:max).max
  end
end

answer = Answer.new(FileReader.new('input.txt').output)
p answer.part_one
p answer.part_two