#= require application

describe "Gato.Game", ->

  describe "a new game", ->
    beforeEach ->
      @game = new Gato.Game
        player_x: "Benito"
        player_o: "Emmanuel"

    it "has an empty board", ->
      for row in @game.board.cells
        for cell in row
          expect(cell.is_empty()).toBeTruthy()

    it "has two players", ->
      expect(@game.player_x).toEqual "Benito"
      expect(@game.player_o).toEqual "Emmanuel"

  describe "first stage", ->
    beforeEach ->
      @game = new Gato.Game

    beforeEach ->
      # x _ _
      # _ o _
      # _ _ _
      @game.write(0,0)
      @game.write(1,1)

    it "should have an x in (0,0)", ->
      expect(@game.board.cell(0,0).val).toEqual "x"

    it "should have an o in (1,1)", ->
      expect(@game.board.cell(1,1).val).toEqual "o"

    it "does not have a winner", ->
      expect(@game.has_winner()).toBeFalsy()

  describe "with two turns", ->
    beforeEach ->
      @game = new Gato.Game

    beforeEach ->
      # x _ x
      # _ o o
      # _ _ _
      # first turn
      @game.write(0,0)
      @game.write(1,1)
      # second turn
      @game.write(0,2)
      @game.write(1,2)


    it "should have an x in (0,2)", ->
      expect(@game.board.cell(0,2).val).toEqual "x"

    it "should have an o in (1,2)", ->
      expect(@game.board.cell(1,2).val).toEqual "o"

    it "does not have a winner", ->
      expect(@game.has_winner()).toBeFalsy()


  describe "a game with winner in the top row", ->
    beforeEach ->
      @game = new Gato.Game

    beforeEach ->
      # x x x
      # _ o o
      # _ _ _
      # first turn
      @game.write(0,0)
      @game.write(1,1)
      # second turn
      @game.write(0,2)
      @game.write(1,2)
      # third turn
      @game.write(0,1)
      @game.write(1,2)

    it "should have an x in (0,1)", ->
      expect(@game.board.cell(0,1).val).toEqual "x"

    it "does not have a winner", ->
      expect(@game.has_winner()).toBeTruthy()

  describe "a winner in the middle row", ->
    beforeEach ->
      @game = new Gato.Game

    beforeEach ->
      # x _ x
      # o o o
      # _ x _
      # first turn
      @game.write(0,0)
      @game.write(1,1)
      # second turn
      @game.write(0,2)
      @game.write(1,2)
      # third turn
      @game.write(2,1)
      @game.write(1,0)

    it "should have an x in (0,0)", ->
      expect(@game.board.cell(0,0).val).toEqual "x"

    it "should have an x in (0,2)", ->
      expect(@game.board.cell(0,2).val).toEqual "x"

    it "should have an x in (2,1)", ->
      expect(@game.board.cell(2,1).val).toEqual "x"

    it "should have an o in (1,0)", ->
      expect(@game.board.cell(1,0).val).toEqual "o"

    it "should have an o in (1,1)", ->
      expect(@game.board.cell(1,1).val).toEqual "o"

    it "should have an o in (1,2)", ->
      expect(@game.board.cell(1,2).val).toEqual "o"

    it "does not have a winner", ->
      expect(@game.has_winner()).toBeTruthy()

  describe "a winner in the third column", ->
    beforeEach ->
      @game = new Gato.Game

    beforeEach ->
      # x _ _
      # x o o
      # x o _
      # first turn
      @game.write(0,0)
      @game.write(1,1)
      # second turn
      @game.write(1,0)
      @game.write(1,2)
      # third turn
      @game.write(2,0)
      @game.write(2,1)

    it "should have an x in (0,0)", ->
      expect(@game.board.cell(0,0).val).toEqual "x"

    it "should have an x in (1,0)", ->
      expect(@game.board.cell(1,0).val).toEqual "x"

    it "should have an x in (2,0)", ->
      expect(@game.board.cell(2,0).val).toEqual "x"

    it "should have an o in (1,1)", ->
      expect(@game.board.cell(1,1).val).toEqual "o"

    it "should have an o in (1,2)", ->
      expect(@game.board.cell(1,2).val).toEqual "o"

    it "should have an o in (2,1)", ->
      expect(@game.board.cell(2,1).val).toEqual "o"

    it "does not have a winner", ->
      expect(@game.has_winner()).toBeTruthy()

  describe "a winner in a diagonal", ->
    beforeEach ->
      @game = new Gato.Game

    beforeEach ->
      # x _ o
      # x o _
      # o x _
      # first turn
      @game.write(0,0)
      @game.write(1,1)
      # second turn
      @game.write(1,0)
      @game.write(0,2)
      # third turn
      @game.write(2,1)
      @game.write(2,0)

    it "should have an x in (0,0)", ->
      expect(@game.board.cell(0,0).val).toEqual "x"

    it "should have an x in (1,0)", ->
      expect(@game.board.cell(1,0).val).toEqual "x"

    it "should have an x in (2,1)", ->
      expect(@game.board.cell(2,1).val).toEqual "x"

    it "should have an o in (1,1)", ->
      expect(@game.board.cell(1,1).val).toEqual "o"

    it "should have an o in (0,2)", ->
      expect(@game.board.cell(0,2).val).toEqual "o"

    it "should have an o in (2,0)", ->
      expect(@game.board.cell(2,0).val).toEqual "o"

    it "does not have a winner", ->
      expect(@game.has_winner()).toBeTruthy()
