class GameObject
  attr_accessor :window
  attr_accessor :width
  attr_accessor :height
  attr_accessor :x
  attr_accessor :y
  attr_accessor :scale_x
  attr_accessor :scale_y

  def initialize(window, x = 0, y = 0)
    @window = window
    @x = x
    @y = y
    @scale_x = 1
    @scale_y = 1
    setup
  end

  def setup
    # provide initialization of subclass here
  end

  def center_x
    x + width/2
  end

  def width
    @width * scale_x
  end

  def height
    @height * scale_y
  end

  def center_x=(x)
    self.x = x - width/2
  end

  def center_y
    y + height/2
  end

  def center_y=(y)
    self.y = y - heigth/2
  end

  def center_point
    [center_x, center_y]
  end

  def right
    x + width
  end

  def right=(r)
    self.x = r - width
  end

  def left
    x
  end

  def top
    y
  end

  def top=(t)
    self.y = t
  end

  def bottom
    y + height
  end

  def bottom=(b)
    self.y = b - height
  end

  def update
  end
end

