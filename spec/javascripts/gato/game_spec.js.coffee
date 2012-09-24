#= require application

describe "Gato.Game", ->

  describe "a new game", ->
    beforeEach ->
      @game = new Gato.Game
        player_x: new Gato.Player "Benito", "x"
        player_o: new Gato.Player "Emmanuel", "o"

    it "has an empty board", ->
      for row in @game.board.cells
        for cell in row
          expect(cell.is_empty()).toBeTruthy()

    it "has two players", ->
      expect(@game.player_x.name).toEqual "Benito"
      expect(@game.player_o.name).toEqual "Emmanuel"

  describe "first stage", ->
    beforeEach ->
      @game = new Gato.Game
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
      expect(=> @game.winner().name).toThrow "No winner"


  describe "a game with winner in the top row", ->
    beforeEach ->
      @game = new Gato.Game
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

    it "should have an x in (0,1)", ->
      expect(@game.board.cell(0,1).val).toEqual "x"

    it "does have a winner and the winner is Player x", ->
      expect(@game.has_winner()).toBeTruthy()
      expect(@game.winner().name).toEqual "Player x"

  describe "a winner in the middle row", ->
    beforeEach ->
      @game = new Gato.Game
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

    it "does have a winner and the winner is Player o", ->
      expect(@game.has_winner()).toBeTruthy()
      expect(@game.winner().name).toEqual "Player o"

  describe "a winner in the third column", ->
    beforeEach ->
      @game = new Gato.Game
      # x _ _
      # x o o
      # x _ _
      # first turn
      @game.write(0,0)
      @game.write(1,1)
      # second turn
      @game.write(1,0)
      @game.write(1,2)
      # third turn
      @game.write(2,0)

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

    it "should not write the symbol", ->
      expect(=> @game.write(2,1)).toThrow "There is a winner"

    it "does have a winner and the winner is Player x", ->
      expect(@game.has_winner()).toBeTruthy()
      expect(@game.winner().name).toEqual "Player x"

  describe "a winner in a diagonal", ->
    beforeEach ->
      @game = new Gato.Game
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

    it "does have a winner and the winner is Player o", ->
      expect(@game.has_winner()).toBeTruthy()
      expect(@game.winner().name).toEqual "Player o"

  describe "writing in an occupied cell", ->
    beforeEach ->
      @game = new Gato.Game
      @game.write(0,0)

    it "should be an error saying that is already occupied", ->
      expect(=> @game.write(0,0)).toThrow "Already occupied"
