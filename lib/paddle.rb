class Paddle < DrawableObject
  EDGE_THRESHOLD = 35

  include Collision

  def initialize(window)
    super window, image_filename
    self.x = window.width / 2 - width / 2
    self.y = window.height - 50
  end

  def draw
    @image.draw x, y, 0, scale_x, scale_y
    # draw_threshold_lines
  end

  def grow
    self.scale_x = 3
  end

  def shrink
    self.scale_x = 0.5
  end

  def normal
    self.scale_x = 1
  end

  def draw_threshold_lines
    c = Gosu::Color::RED
    Gosu.draw_line x + EDGE_THRESHOLD, top, c, x + EDGE_THRESHOLD, bottom, c, 1
    Gosu.draw_line right - EDGE_THRESHOLD, top, c, right - EDGE_THRESHOLD, bottom, c, 1
  end

  def process_mouse(x, y)
    effective_x = x - width/2
    self.x = [[0, effective_x].max, window.width - width].min
  end

  def image_filename
    'assets/paddle.png'
  end
end

