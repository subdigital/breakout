class Ball < DrawableObject
  include Movement
  include Collision

  attr_reader :color

  def initialize(window, ball_color, x = 0, y = 0)
    @color = ball_color
    super window, image_filename, x, y
  end

  private

  def image_filename
    "assets/ball_#{color}.png"
  end
end

