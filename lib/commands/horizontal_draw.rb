module Commands
  class HorizontalDraw < ::Command
    attr_reader :x1, :x2, :y, :colour

    # Initialize HorizontalDraw Class.
    #
    # @param [App] app App object running the application.
    # @param [Integer] x1 the beginning coordinates.
    # @param [Integer] x2 the ending coordinates.
    # @param [Integer] y the line to modify.
    # @param [Char] colour the colour to apply on the column.
    def initialize(app, x1, x2, y, colour)
      super(app)
      @x1 = x1.to_i
      @x2 = x2.to_i
      @y = y.to_i
      @colour = colour
    end

    # Execute the command.
    # Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
    def execute
      (x1..x2).each do |x|
        app.bitmap[x, y] = colour
      end
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [HorizontalDraw] the newly created instance of the command.
    def self.create(app, *args)
      fail InvalidArguments if args.length != 4
      fail InvalidArguments unless args[0].is_i? && args[1].is_i? && args[2].is_i? && args[3].is_colour?
      new(app, *args)
    end
  end
end