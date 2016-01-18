module States
  class GameOver < GameState
    def initialize(game)
      super game
      @font = Gosu::Font.new(50)
    end

    def process_input(id)
      case id
      when Gosu::MsLeft then
        game.reset
      end
    end

    def draw
      @font.draw_rel "GAME OVER", game.width/2, game.height/2, 0.5, 0.5, 1, 1
    end
  end
end
