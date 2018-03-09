require 'test/unit'
require 'test/unit/autorunner'
require './chessercise-target'

class PossibleMoves < Test::Unit::TestCase
  $my_argv = ARGV.dup
  p $my_argv
  p $my_argv.length
  def setup
    @chess = ChesserciseTarget.new
  end

  def test_get_most_distant_tile
    list = ['h1', 'f1', 'b3', 'f3', 'c4', 'e4' 'c2', 'h8']
    expected_result =  @chess.get_most_distant_tile('b1', list)[0]
    assert_equal( expected_result, 'h8')

  end

  def test_if_killed_enemy
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
    list = ['h1', 'f1', 'b3', 'f3', 'c4', 'e4' 'c2', 'h8']
    assert_equal( true, @chess.killEnemy(:knight,['b1'], list, moves, 1, 'h8')[0])
  end

  def test_minimum_moves
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
    list = ['h1', 'f1', 'b3', 'f3', 'c4', 'e4' 'c2', 'h8']
    assert_equal( 5, @chess.killEnemy(:knight,['b1'], list, moves, 1, 'h8')[1])
  end

end