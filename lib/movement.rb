Vector = Struct.new(:x, :y)
module Movement
  attr_accessor :vector

  def update
    self.vector ||= Vector.new(0,0)

    self.x += vector.x
    self.y += vector.y
  end

  def reflect_vertical
    self.vector = Vector.new(vector.x, -vector.y)
  end

  def reflect_horizontal
    self.vector = Vector.new(-vector.x, vector.y)
  end
end
