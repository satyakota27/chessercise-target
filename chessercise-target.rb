#input (-piece 'Knight' -location 'd5')
unless ARGV.length >= 4
  puts 'please enter all the input data'
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
piece_type = ARGV[1].to_sym.downcase
location = ARGV[3].downcase

unless %w{knight rook queen}.include?(ARGV[1].downcase)
  puts 'please enter a valid piece type. KNIGHT or ROOK or QUEEN'
  exit
end



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

   board_possible_moves.collect { |m|
    x = (m[0] + 96).chr
    y = m[1]
    "#{x}#{y}"
  }.join(', ')

end

if ARGV[4] && ARGV[4].casecmp('-target')

#generate random list
  list = []
  while list.length < 9
    x = ( 1+rand(8) + 96).chr
    y = 1+rand(8)
    list.push(x+y.to_s) unless list.include? location
    list.uniq!
  end
  list
# end generation of random list

  puts 'Board possible Moves are: '+ output_moves(piece_type, location, moves)
  puts 'Randomly generated 8 opposition Locations are:'
  puts list

  #method to check kills
  #def killEnemy(piece_type, location_update, moves)

  #end


  found = false
  moveCount = 0
  while !found
    moveCount = moveCount + 1
    #need to wrap in a function to call it recursively
    list.each do |loc|
      if output_moves(piece_type, location, moves).include?(loc)
        puts 'opposition '+ loc + " Killed in #{moveCount} move/s"
        found = true
        exit
      end
    end
    #killEnemy(piece_type, location, moves)
  end

end