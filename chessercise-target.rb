class Chessercise
#input (-piece 'Knight' -location 'd5')
unless ARGV.length >= 2
  message =  'please enter all the input data'
  puts message
  exit 1
end

unless %w{knight rook queen}.include?(ARGV[0].downcase)
  puts 'please enter a valid piece type. KNIGHT or ROOK or QUEEN'
  exit
end

#coordinates of pieces (hashes)
moves = {
    rook: [{ x: 1, y: 0, steps: 7},
           { x: 0, y: 1, steps: 7},
           { x: 0, y: -1, steps: 7},
           { x: -1, y: 0, steps: 7}],
    queen: [{ x: 1, y: 0, steps: 7},
            { x: 0, y: 1, steps: 7},
            { x: 0, y: -1, steps: 7},
            { x: -1, y: 0, steps: 7},
            { x: 1, y: 1, steps: 7},
            { x: 1, y: -1, steps: 7},
            { x: -1, y: -1, steps: 7},
            { x: -1, y: 1, steps: 7}],
    knight: [{ x: 2, y: 1, steps: 1 },
             { x: 1, y: 2, steps: 1 },
             { x: 1, y: -2, steps: 1 },
             { x: 2, y: -1, steps: 1 },
             { x: -1, y: 2, steps: 1 },
             { x: -2, y: 1, steps: 1 },
             { x: -1, y: -2, steps: 1 },
             { x: -2, y: -1, steps: 1 }]
}
piece_type = ARGV[0].to_sym.downcase
location = ARGV[1].downcase

#Calculate Board possible moves
def output_moves(piece_type, location, moves)
  #setting up location coordinates
  location_coords = location.split(//)
  x = location_coords[0].ord - 96
  y = location_coords[1].to_i

  if x < 1 || y < 1 || y > 8 || x > 8 || location.length!=2
    puts 'please provide a valid location for the piece'
    exit
  end

#calculating possible moves of rook
  all_possible_moves = moves[piece_type].flat_map do |move|
    (1..move[:steps]).collect do |step|
      new_x = x + (move[:x] * step)
      new_y = y + (move[:y] * step)
      [new_x, new_y]
    end
  end.sort do |m1, m2|
    c = (m1[1] <=> m2[1])
    c == 0 ? (m1[0] <=> m2[0]) : c
  end

  board_possible_moves = all_possible_moves.reject { |p| p[0] < 1 || p[1] < 1 || p[0] > 8 || p[1] > 8 }
  movesList = []
   board_possible_moves.collect { |m|
    x = (m[0] + 96).chr
    y = m[1]
    movesList<< x + y.to_s
  }
  movesList
end

  def get_most_distant_tile(piece_location, tiles)
    piece = piece_location.split(//)
    piece_x = piece[0].ord
    piece_y = piece[1].to_i
    tiles.collect do |tile|
      distance = 0
      opp = tile.split(//)
      opp_x = opp[0].ord
      opp_y = opp[1].to_i
      distance = (opp_x - piece_x).abs + (opp_y - piece_y).abs
      [tile, distance]
    end.sort do |m1, m2|
      c = (m1[1] <=> m2[1])
      c == 0 ? (m1[0] <=> m2[0]) : c
    end.last

  end

#method to print the least number of moves required for the distant opposition
  def killEnemy(piece_type, location_list, list, moves, mCount, enemy)
    found = false
    iteration_list = []
    location_list.each do |pos|
      output_moves(piece_type, pos, moves).each do |loc|
        iteration_list << loc
        if enemy == loc
          puts 'minimum number of moves to kill opposition at the location '+ loc + ": #{mCount} move/s"
          found = true
          exit
        end
      end
    end
    unless found
      # removing duplicates
      iteration_list.uniq!
      puts "Not found after #{mCount} move/s, trying moves from: #{iteration_list}"
      mCount = mCount + 1
      killEnemy(piece_type, iteration_list, list, moves, mCount, enemy)
    end
  end

  @chess_moves = Chessercise.new
  puts 'Board possible Moves are: '
  puts  @chess_moves.output_moves(piece_type, location, moves)

if ARGV[2] && ARGV[2].casecmp('-target')

#generate random list
  list = []
  while list.length < 8
    coord = (1+rand(8) + 96).chr + (1+rand(8)).to_s
    unless list.include? location || list.include?(coord)
      list.push(coord)
    end
  end
  puts 'Randomly generated 8 opposition Locations are:'
  puts list
# end generation of random list

  target = @chess_moves.get_most_distant_tile(location, list)
  puts 'most distant tile: ' + target[0]

  location_list = []
  moveCount = 1
  location_list << location
  @chess_moves.killEnemy(piece_type, location_list, list, moves, moveCount, target[0])
end
end