class FileReader
  def initialize(file)
    @file = file
    @output = []
  end

  def output
    read_file
    @output
  end

  private
  
  def read_file
    File.foreach(@file) do |line|
      @output << prepare(line)
    end
  end

  def prepare(line)
    line.chomp
  end
end

class ScoreCalculator
  THROW_POINTS = {rock: 1, paper: 2, scissors: 3}
  OUTCOME_POINTS = {win: 6, draw: 3, lose: 0 }
  OPPONENT_VALUES = {A: :rock, B: :paper, C: :scissors}
  SELF_VALUES = {X: :rock, Y: :paper, Z: :scissors}
  GOALS = {X: :lose, Y: :draw, Z: :win}
  WINS = {rock: :scissors, paper: :rock, scissors: :paper}

  def initialize(input)
    @rounds = format(input)
  end
  
  
  def calculate_score
    @rounds.map do |round|
      throw_score(round) + outcome_score(round)
    end.sum
  end
  
  def calculate_encrypted_score
    @rounds.map do |round|
      encrypted_throw_score(round) + encrypted_outcome_score(round)
    end.sum
  end

  private

  def format(input)
    input.map {|e| e.split(" ").map(&:to_sym)}
  end

  def encrypted_throw_score(round)
    THROW_POINTS[determine_throw(round)]
  end

  def encrypted_outcome_score(round)
    OUTCOME_POINTS[GOALS[round.last]]
  end

  def throw_score(round)
    THROW_POINTS[SELF_VALUES[round.last]]
  end

  def outcome(round)
    if OPPONENT_VALUES[round.first] == SELF_VALUES[round.last]
      :draw
    elsif WINS[SELF_VALUES[round.last]] == OPPONENT_VALUES[round.first]
      :win
    else
      :lose
    end
  end

  def determine_throw(round)
    case GOALS[round.last]
    when :draw
      OPPONENT_VALUES[round.first]
    when :lose
      WINS[OPPONENT_VALUES[round.first]]
    when :win
      WINS.invert[OPPONENT_VALUES[round.first]]
    end
  end

  def outcome_score(round)
    OUTCOME_POINTS[outcome(round)]
  end
end

p ScoreCalculator.new(FileReader.new('input.txt').output).calculate_encrypted_score
