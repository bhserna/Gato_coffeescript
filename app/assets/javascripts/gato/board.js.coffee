class Gato.Board
  constructor: ->
    @cells = [
      [new Gato.Cell, new Gato.Cell, new Gato.Cell]
      [new Gato.Cell, new Gato.Cell, new Gato.Cell]
      [new Gato.Cell, new Gato.Cell, new Gato.Cell]
    ]

  write_cell: (row, column, symbol) ->
    throw "Already occupied" unless @cell(row,column).is_empty()
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
