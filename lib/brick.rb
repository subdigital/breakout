class Brick < DrawableObject
  include Collision
  attr_reader :color

  def initialize(window, brick_color, x, y)
    @color = brick_color
    super window, image_filename, x, y
  end

  def powerup?
    false
  end

  private

  def image_filename
    "assets/brick_#{color}.png"
  end
end

