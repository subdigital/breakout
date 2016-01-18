module States
  class Ready < GameState

    def initialize(game)
      super game
      @font = Gosu::Font.new(50)
      @start_sound = Gosu::Sample.new('assets/game_start.wav')
      game.initialize_balls(1)
    end

    def update
      game.balls.each {|ball| position_ball_above_paddle(ball)}
    end

    def position_ball_above_paddle(ball)
      ball.center_x = game.paddle.center_x
      ball.bottom = game.paddle.top - 1
    end

    def process_input(id)
      case id
      when Gosu::MsLeft
        start_playing
      end
    end

    def start_playing
      @start_sound.play
      transition_to(States::Playing)
    end

    def draw
      @font.draw_rel "Get Ready!", game.width/2, game.height/2, 0.5, 0.5, 1, 1
    end

  end
end

