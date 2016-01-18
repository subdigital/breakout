module Collision
  attr_accessor :collision_disabled

  def collides_with?(other)
    return if other.collision_disabled || collision_disabled
    x_overlap = [0, [right, other.right].min - [left, other.left].max].max
    y_overlap = [0, [bottom, other.bottom].min - [top, other.top].max].max
    x_overlap * y_overlap != 0
  end
end

