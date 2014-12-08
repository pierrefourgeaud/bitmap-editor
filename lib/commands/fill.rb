module Commands
  class Fill < ::Command
    attr_reader :x, :y, :colour

    # Initialize Fill Class.
    #
    # @param [App] app App object running the application.
    # @param [Integer] x the x of the pixel
    # @param [Integer] y the y of the pixel
    # @param [Char] colour the colour to apply on the column.
    def initialize(app, x, y, colour)
      super(app)
      @x = x.to_i
      @y = y.to_i
      @colour = colour
    end

    # Execute the command.
    # Fill the region R with the colour C. R is defined as: Pixel (X,Y) belongs to R.
    # Any other pixel which is the same colour as (X,Y) and shares a common side with
    # any pixel in R also belongs to this region.
    def execute
      fail MissingBitmap if app.bitmap.nil?
      fill(app.bitmap, x, y, app.bitmap[x, y])
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Fill] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 3) if args.length != 3
      fail InvalidArguments unless args[0].is_i? && args[1].is_i? && args[2].is_colour?
      new(app, *args)
    end

    private

    # Recursive method implementing the fill algorithm.
    #
    # @param [Bitmap] bitmap Bitmap object created previously.
    # @param [Integer] px the pixel in x we want to modify
    # @param [Integer] py the pixel in y we want to modify
    # @param [Char] ocolour the colour the pixel must have to be modified.
    def fill bitmap, px, py, ocolour
      return unless bitmap.check_range(px, py) && bitmap[px, py] == ocolour

      bitmap[px, py] = colour
      fill(bitmap, px+1, py, ocolour)
      fill(bitmap, px-1, py, ocolour)
      fill(bitmap, px, py+1, ocolour)
      fill(bitmap, px, py-1, ocolour)
    end
  end
end