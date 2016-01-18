class ShinyBrick < Brick

  ANIMATION_SPEED = 7

  def setup
    @p1 = Gosu::Image.new('assets/particle_star1.png')
    @p2 = Gosu::Image.new('assets/particle_star2.png')
    @frame_time = 0
    @current_frame = 0
  end

  def animation_frames
    @frames ||= begin
                  Gosu.random(2, 18).to_i.times.map { nil } +
                  [@p1, @p2, @p1] +
                  Gosu.random(2, 18).to_i.times.map { nil }
                end
  end

  def powerup?
    true
  end

  def dt
    Gosu::milliseconds / 1000.0
  end

  def update
    @current_frame = (dt*ANIMATION_SPEED % animation_frames.length).to_i
  end

  def draw
    super
    f = animation_frames[@current_frame]
    if f
      f.draw right - 25, top + 2, 0
    end
  end
end
