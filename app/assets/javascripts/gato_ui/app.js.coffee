window.GatoUi = {}

class GatoUi.App
  constructor: ->
    @new_game()
    $("body").on "click", ".new_game", @new_game

  new_game: =>
    @game = new Gato.Game
    @view = new GatoUi.GameView(@game)
    @controller = new GatoUi.GameController(@view, @game)
    $("body").html @view.render().el
    $("body").append "<a class='new_game' href='#'>NEW GAME</a>"
    false

class GatoUi.GameView
  constructor: (@game) ->
    @el = $ "<div>"
    @el.addClass "game"

  render: ->
    board = new GatoUi.BoardView(@game.board)
    current_player = $("<p class='current_player'>").text(@game.current_player.name)
    @el.html board.render().el
    @el.append current_player
    this

class GatoUi.GameController
  constructor: (@view, @game) ->
    @view.el.on "click", "td", @write_cell

  write_cell: (e) =>
    td = $ e.target
    row = parseInt td.data("row")
    column = parseInt td.data("column")

    try
     @game.write(row, column)
     @view.render()
    catch error
      alert error

    try
      alert "The winner is #{@game.winner().name}"
    catch error


class GatoUi.BoardView
  #eco does not want to work =(
  template: ->
    """
    <tr>
      <td data-row="0" data-column="0">#{ @board.cell(0,0).val }</td>
      <td data-row="0" data-column="1">#{ @board.cell(0,1).val }</td>
      <td data-row="0" data-column="2">#{ @board.cell(0,2).val }</td>
    </tr>
    <tr>
      <td data-row="1" data-column="0">#{ @board.cell(1,0).val }</td>
      <td data-row="1" data-column="1">#{ @board.cell(1,1).val }</td>
      <td data-row="1" data-column="2">#{ @board.cell(1,2).val }</td>
    </tr>
    <tr>
      <td data-row="2" data-column="0">#{ @board.cell(2,0).val }</td>
      <td data-row="2" data-column="1">#{ @board.cell(2,1).val }</td>
      <td data-row="2" data-column="2">#{ @board.cell(2,2).val }</td>
    </tr>
    """

  constructor: (@board) ->
    @el = $ "<table>"
    @el.addClass "board"

  render: =>
    @el.html @template(@board)
    this
