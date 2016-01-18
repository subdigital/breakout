class Powerup < DrawableObject
  ANIMATION_SPEED = 8

  include Movement
  include Collision

  def initialize(window, x, y)
    super window, image_filename, x, y
    self.vector = Vector.new(0, 4)
    @current_frame = 0
  end

  def dt
    Gosu::milliseconds / 1000.0
  end

  def update
    super
    @current_frame = (dt*ANIMATION_SPEED % animation_frames.length).to_i
  end

  def draw
    f = animation_frames[@current_frame]
    if f
      f.draw x, y, 0
    end
  end

  private

  def image_filename
    'assets/powerup-1.png'
  end

  def static_frame
    Gosu::Image.new image_filename
  end

  def animation_frames
    @frames ||= begin
                  static = static_frame
                  other_frames = 9.times.map {|i| Gosu::Image.new("assets/powerup-#{i+1}.png") }
                  static_fill = 10.times.collect { static }
                  [static] + other_frames + static_fill
                end
  end
end
