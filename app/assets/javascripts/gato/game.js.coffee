class Gato.Game
  constructor: (args = {}) ->
    @board    = args.board || new Gato.Board
    @player_x = args.player_x || new Gato.Player("Player x", "x")
    @player_o = args.player_o || new Gato.Player("Player o", "o")

    @current_player = @player_x

  write: (row, column) ->
    throw "There is a winner" if @has_winner()
    @board.write_cell(row, column, @current_player.symbol)
    @_change_player()
    true

  winner: ->
    throw "No winner" unless @has_winner()
    @current_player

  has_winner: ->
    @board.has_row_with_equal_symbols() or
    @board.has_column_with_equal_symbols() or
    @board.has_diagonal_with_equal_symbols()

  _change_player: ->
    return if @has_winner()
    switch @current_player
      when @player_x then @current_player = @player_o
      when @player_o then @current_player = @player_x
