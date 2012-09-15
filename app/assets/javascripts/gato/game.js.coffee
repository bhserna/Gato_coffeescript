window.Gato = {}

class Gato.Game
  constructor: (args = {}) ->
    @board    = args.board || new Gato.Board
    @player_x = args.player_x || "Player x"
    @player_o = args.player_o || "Player o"

    @_current_symbol = "x"

  write: (row, column) ->
    @board.write_cell(row, column, @_current_symbol)
    @_change_symbol()

  has_winner: ->
    return true if @board.has_row_with_equal_symbols()
    return true if @board.has_column_with_equal_symbols()
    return true if @board.has_diagonal_with_equal_symbols()
    false

  _change_symbol: ->
    switch @_current_symbol
      when "x" then @_current_symbol = "o"
      when "o" then @_current_symbol = "x"


class Gato.Board
  constructor: ->
    @cells = [
      [new Gato.Cell, new Gato.Cell, new Gato.Cell]
      [new Gato.Cell, new Gato.Cell, new Gato.Cell]
      [new Gato.Cell, new Gato.Cell, new Gato.Cell]
    ]

  write_cell: (row, column, symbol) ->
    @cell(row,column).val = symbol

  cell: (row, column) ->
    @cells[row][column]

  has_row_with_equal_symbols: ->
    for row in [0..2]
      return true if @_cells_are_equal(@cell(row,0), @cell(row,1), @cell(row,2))
    false

  has_column_with_equal_symbols: ->
    for column in [0..2]
      return true if @_cells_are_equal(@cell(0,column), @cell(1,column), @cell(2,column))
    false

  has_diagonal_with_equal_symbols: ->
    return true if @_cells_are_equal(@cell(0,0), @cell(1,1), @cell(2,2))
    return true if @_cells_are_equal(@cell(0,2), @cell(1,1), @cell(2,0))
    false

  _cells_are_equal: (cell_one, cell_two, cell_three) ->
    cell_one.val == cell_two.val == cell_three.val and not cell_one.is_empty()

class Gato.Cell
  constructor: ->
    @val = ""

  is_empty: ->
    @val == ""
