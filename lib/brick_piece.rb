module Gravity
  def update
    super
    self.vector = Vector.new(vector.x, vector.y + 0.4)
  end
end

class BrickPiece < Brick
  include Movement
  include Gravity
  
  attr_reader :brick_side
  attr_reader :angle
  attr_reader :rot_v
  attr_reader :rot_center
  attr_reader :alpha
  
  def initialize(window, color, x, y, side)
    @brick_side = side
    super window, color, x, y
    x_speed = Gosu.random(1, 5) * ((side == :left) ? -1 : 1)
    y_speed = Gosu.random(0, -4)
    self.vector = Vector.new(x_speed, y_speed)
    
    @angle = side == :left ? 0 : 0
    @rot_v = side == :left ? -Math::PI : Math::PI
    @rot_center = (side == :left) ? [1, 1] : [0, 1]
    @alpha = 0xff_ffffff
    @alpha_decay = 0x05_000000
    
    # adjust position to line up since we're rotating
    self.x += width
    self.y += height
  end
  
  def load_image
    width = 32
    height = 32
    x = (brick_side == :left) ? 0 : width
    @image = Gosu::Image.new(window, image_filename, false, x, 0, width, height)
  end 
  
  def update
    super
    @angle += rot_v / 5
    @alpha -= @alpha_decay
    @alpha = [0, @alpha].max
  end
  
  def draw
    # @image.draw x, y, 0, scale_x, scale_y, alpha
    @image.draw_rot x, y, 0, angle, rot_center[0], rot_center[1], scale_x, scale_y, alpha
  end
end