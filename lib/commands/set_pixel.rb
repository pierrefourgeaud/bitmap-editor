module Commands
  class SetPixel < ::Command
    attr_reader :x, :y, :colour

    # Initialize SetPixel Class.
    #
    # @param [App] app App object running the application.
    # @param [Integer] x the x of the pixel
    # @param [Integer] y the y of the pixel
    # @param [Char] colour the colour to apply on this pixel.
    def initialize(app, x, y, colour)
      super(app)
      @x = x.to_i
      @y = y.to_i
      @colour = colour
    end

    # Execute the command. Set the pixel (x, y) to the colour colour.
    def execute
      @app.bitmap[@x-1, @y-1] = @colour
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [SetPixel] the newly created instance of the command.
    def self.create(app, *args)
      new(app, *args)
    end
  end
end