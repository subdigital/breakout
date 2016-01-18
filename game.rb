require 'gosu'
require 'hasu'
require 'set'

Hasu.load "lib/rect.rb"
Hasu.load "lib/game_object.rb"
Hasu.load "lib/drawable_object.rb"
Hasu.load "lib/mouse_input.rb"
Hasu.load "lib/movement.rb"
Hasu.load "lib/collision.rb"
Hasu.load "lib/level.rb"
Hasu.load "lib/ball.rb"
Hasu.load "lib/paddle.rb"
Hasu.load "lib/brick.rb"
Hasu.load "lib/shiny_brick.rb"
Hasu.load "lib/brick_piece.rb"
Hasu.load "lib/powerup.rb"
Hasu.load "lib/game_state.rb"
Hasu.load "lib/states/playing.rb"
Hasu.load "lib/states/ready.rb"
Hasu.load "lib/states/game_over.rb"

class Game < Hasu::Window
  attr_reader :score
  attr_reader :current_level
  attr_reader :lives
  attr_reader :paddle
  attr_reader :balls
  attr_reader :bricks
  attr_reader :other_objects
  attr_reader :mouse_input
  attr_reader :keyboard_input
  attr_accessor :state

  MAX_LIVES = 3

  def initialize
    super 1024, 768, fullscreen: false
    self.caption = "Breakout!"
  end

  def button_down(id)
    case id
    when Gosu::KbEscape then close
    when Gosu::KbP then pause
    when Gosu::KbM then mute_music
    when Gosu::KbZ then paddle.grow
    when Gosu::KbX then paddle.shrink
    when Gosu::KbC then paddle.normal
    when Gosu::KbB then add_ball
    else
      state.process_input(id) if state && state.respond_to?(:process_input)
    end
  end

  def pause
    if state == :paused
      self.state = @previous_state
    else
      @previous_state = state
      self.state = :paused
    end
  end

  def mute_music
    if @music.playing?
      @music.pause
    else
      @music.play
    end
  end

  def add_ball
    ball = Ball.new(self, @balls.first.color, @balls.first.x, @balls.first.y)
    ball.vector = Vector.new(-@balls.first.vector.x, -@balls.first.vector.y.abs)
    @balls << ball
  end

  def die!
    @lives -= 1

    puts "Lives left: #{@lives}"
    if @lives >= 0
      self.state = States::Ready.new(self)
    else
      game_over
    end
  end

  def reset
    @current_level = 1
    @lives = MAX_LIVES
    @score = 0
    @score_font = Gosu::Font.new(14)
    @bg = Gosu::Image.new('assets/space_bg.jpg')

    @paddle = Paddle.new(self)
    @other_objects = []
    @mouse_input = MouseInput.new(@paddle)

    @music = Gosu::Song.new('assets/DST-ElectroRock.mp3')
    @music.volume = 0.75
    @music.play(true)

    start_game
  end

  def start_game
    load_level
    self.state = States::Ready.new(self)
  end

  def load_level
    @bricks = level.generate_bricks
  end

  def break_brick(brick)
    @score += 50

    # remove brick so it doesn't collide with ball
    @bricks.delete brick

    # spawn 2 brick pieces, positioned over the current brick
    left = BrickPiece.new(self, brick.color, brick.x, brick.y, :left)
    right = BrickPiece.new(self, brick.color, brick.center_x, brick.y, :right)
    @other_objects << left
    @other_objects << right

    # powerup?
    if brick.powerup?
      spawn_powerup(brick.center_x, brick.center_y)
    end

    # check for win
    if @bricks.count == 0
      advance_level
    end
  end

  def spawn_powerup(x, y)
    @other_objects << Powerup.new(self, x - 20, y)
  end

  def advance_level
    @current_level += 1
    if level_exists?(@current_level)
      start_game
    else
      game_over
    end
  end

  def collect_powerup!(powerup)
    @other_objects.delete powerup
    add_ball
  end

  def game_over
    self.state = States::GameOver.new(self)
  end

  def level_exists?(level)
    File.exists?(filename_for_level(level))
  end

  def level
    Level.new(self, filename_for_level(current_level))
  end

  def filename_for_level(level)
    base = File.expand_path(File.dirname(__FILE__))
    File.join(base, 'levels', "level#{level}.dat")
  end

  def initialize_balls(count)
    @balls = Set.new(count.times.map { Ball.new(self, :grey) })
  end

  def game_objects
    [
      @balls.to_a, @paddle, @bricks.to_a, @other_objects
    ].flatten
  end

  def update
    return if state == :paused

    mouse_input.process_mouse(mouse_x, mouse_y)
    game_objects.each(&:update)
    state.update if state && state.respond_to?(:update)

    remove_offscreen
  end

  def remove_offscreen
    to_remove = []
    @other_objects.each do |o|
      if (o.right < 0 || o.left > width) && (o.bottom < 0 || o.top > height)
        to_remove << o
      end
    end
    @other_objects -= to_remove
  end

  def draw
    draw_background
    draw_score
    draw_lives
    game_objects.each(&:draw)
    state.draw if state && state.respond_to?(:draw)
  end

  def draw_lives
    life = Gosu::Image.new('assets/ball_grey.png')
    margin = 10
    x = width - MAX_LIVES * life.width - (MAX_LIVES+1) * margin
    y = 10
    lives.times do |i|
      life.draw x, y, 0, 0.75, 0.75
      x += life.width*0.75 + margin
    end
  end

  def draw_score
    @score_font.draw "Score: #{@score}", 25, 10, 0
  end

  def draw_background
    @bg.draw 0, 0, 0
  end
end

Game.run
