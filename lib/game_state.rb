class GameState
  attr_reader :game

  def initialize(game)
    @game = game
    puts "STATE: #{self.class.name}"
  end

  def update
  end

  def process_input(id)
  end

  def draw
  end

  def transition_to(state_class)
    game.state = state_class.new(game)
  end
end

