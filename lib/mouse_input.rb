class MouseInput
  attr_accessor :object
  attr_reader :last_x
  attr_reader :last_y

  def initialize(obj)
    @object = obj
  end

  def process_mouse(x, y)
    @last_x, @last_y = x, y
    object.process_mouse(x, y) if object
  end
end

