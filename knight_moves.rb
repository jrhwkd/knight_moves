# knight_moves
# a function which takes a start space and and end space
# shows returns the spaces traveled of a knight chess piece

module KnightData
  POSSIBLE_MOVES = [[-2, 1], [-1, 2], [1, 2], [2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
end

class SquareMoves
  #tree
  @@all_moves = []
  include KnightData
  attr_reader :space, :moves, :parent
  def initialize(space, parent = nil)
    @space = space
    @moves = calc_moves(@space)
    @parent = parent
  end
  
  private 

  def calc_moves(space)
    moves = []
    POSSIBLE_MOVES.each do |t| 
      next if space[0] + t[0] > 7 || space[1] + t[1] > 7
      next if space[0] + t[0] < 0 || space[1] + t[1] < 0
      next if @@all_moves.include?([space[0] + t[0], space[1] + t[1]])
      moves.push([space[0] + t[0], space[1] + t[1]])
      @@all_moves.push([space[0] + t[0], space[1] + t[1]])
    end
    moves.map do |move|
      SquareMoves.new(move, self) if !moves.empty? && move != nil
    end
  end

end

def display_parent(node)
  return if node.parent.nil?
  display_parent(node.parent)
  p node.parent.space
end

def display_num_moves(node)
  return 0 if node.parent.nil?
  display_num_moves(node.parent) + 1
end

def knight_moves(start, target)
  queue = []
  current_position = SquareMoves.new(start)
  until current_position.space == target
    current_position.moves.each { |move| queue.push(move) }
    current_position = queue.shift
  end
  puts "Number of moves:\n"
  p display_num_moves(current_position)
  puts "Your moves:\n"
  display_parent(current_position)
  p current_position.space
end

knight_moves([0, 0], [7, 7])