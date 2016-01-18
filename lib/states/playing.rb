module States
  class Playing < GameState
    def initialize(game)
      super game
      game.balls.each {|b| b.vector = compute_initial_vector }
      load_sounds
    end

    def paddle
      game.paddle
    end

    def update
      check_wall_collision
      check_paddle_collision
      check_brick_collision
      check_other_collisions
    end

    def process_input(id)
    end

    def draw
    end

    def check_brick_collision
      game.balls.each do |ball|
        brick = game.bricks.select {|b| ball.collides_with?(b) }.first
        if brick
          # check which side we're on so we know how to deflect
          dr = (ball.left - brick.right).abs
          dl = (ball.right - brick.left).abs
          dt = (ball.bottom - brick.top).abs
          db = (ball.top - brick.bottom).abs

          closest_side = [dr, dl, dt, db].min
          case closest_side
          when dr then
            ball.x = brick.right
            ball.reflect_horizontal
          when dl then
            ball.right = brick.left
            ball.reflect_horizontal
          when dt then
            ball.bottom = brick.top
            ball.reflect_vertical
          when db then
            ball.top = brick.bottom
            ball.reflect_vertical
          end

          @hit.play
          game.break_brick brick
        end
      end
    end

    def check_other_collisions
      obj = game.other_objects.select {|o| paddle.collides_with?(o) }.first
      case obj
      when Powerup then
        @powerup.play
        game.collect_powerup!(obj)
      end
    end


    def check_wall_collision
      game.balls.each do |ball|
        if ball.vector.x > 0
          # moving right
          if ball.right >= game.width
            ball.right = game.width - 1
            ball.reflect_horizontal
            @blip.play
          end
        else
          #moving left
          if ball.x <= 0
            ball.x = 1
            ball.reflect_horizontal
            @blip.play
          end
        end

        if ball.vector.y < 0
          # moving up
          if ball.top <= 0
            ball.y = 1
            ball.reflect_vertical
            @blip.play
          end
        else
          # moving down
          if ball.bottom >= game.height
            @die.play
            game.balls.delete ball
            game.die! if game.balls.count == 0
          end
        end
      end
    end

    def check_paddle_collision
      game.balls.each do |ball|
        if ball.left <= paddle.right &&
          ball.right >= paddle.left &&
          ball.bottom >= paddle.top

          ball.bottom = paddle.top - 1
          ball.reflect_vertical

          # check edges
          threshold = Paddle::EDGE_THRESHOLD
          left_edge_distance = ball.right - paddle.left
          if left_edge_distance < threshold
            vx = Math.sqrt(threshold - left_edge_distance).to_i
            ball.vector = Vector.new(ball.vector.x - vx, ball.vector.y)
          end

          right_edge_distance = paddle.right - ball.left
          if right_edge_distance < threshold
            vx = Math.sqrt(threshold - right_edge_distance).to_i
            ball.vector = Vector.new(ball.vector.x + vx, ball.vector.y)
          end

          @blip.play
        end
      end
    end

    def compute_initial_vector
      x = 9 + Gosu.random(0, 6).to_i * (Gosu.random(0, 2).to_i == 0 ? 1 : -1)
      y = -3 - Gosu.random(0, 5).to_i
      Vector.new(x, y)
    end

    def load_sounds
      @hit = Gosu::Sample.new('assets/hit.wav')
      @die = Gosu::Sample.new('assets/die.wav')
      @blip = Gosu::Sample.new('assets/blip.wav')
      @powerup = Gosu::Sample.new('assets/powerup1.wav')
    end
  end
end

