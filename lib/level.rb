class Level
  attr_reader :window
  attr_reader :filename

  def initialize(window, filename)
    @window = window
    @filename = filename
  end

  def colors
    {
      "g" => :grey,
      "p" => :purple,
      "n" => :green,
      "y" => :yellow,
      "r" => :red,
      "b" => :blue
    }
  end

  def brick_width
    64
  end

  def brick_height
    32
  end

  def gutter_width
    64
  end

  def bricks_per_row
    (window.width - gutter_width * 2) / brick_width
  end

  def generate_bricks
    x = 0
    y = 0
    bricks = Set.new
    puts "Reading level #{filename}"
    file = File.open(@filename, 'r')
    file.each_line do |line|
      line.chars.each do |char|
        brick_color = colors[char]
        if brick_color
          # create a brick here
          brick_class = brick_color == :blue ? ShinyBrick : Brick
          brick = brick_class.new(window, brick_color, x, y)
          bricks << brick
        end
        x += brick_width + 0
      end
      x = 0

      y += brick_height + 0
    end
    file.close
    bricks
  end
end

