class DrawableObject < GameObject
  attr_reader :image

  def initialize(window, image_filename, x = 0, y = 0)
    super(window, x, y)
    load_image
    self.width = @image.width
    self.height = @image.height
  end

  def draw
    raise "Unable to draw #{self.class} because x or y was nil" unless x && y
    image.draw x, y, 0, scale_x, scale_y
  end

  def load_image
    @image = Gosu::Image.new(window, image_filename)
  end
end

