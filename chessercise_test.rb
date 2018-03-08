require 'test/unit'
require './chessercise-target'

class PossibleMoves < Test::Unit::TestCase

  def setup
    @chess = Chessercise.new
  end

  def test_get_most_distant_tile

    list = ['h1', 'f1', 'b3', 'f3', 'c4', 'e4' 'c2', 'h8']
    expected =  @chess.get_most_distant_tile('b1', list)
    assert.equal expected[0], 'h8'
  end

end