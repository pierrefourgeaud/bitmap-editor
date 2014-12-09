module Commands
  class VerticalDraw < ::UndoableCommand
    attr_reader :x, :y1, :y2, :colour

    # Initialize VerticalDraw Class.
    #
    # @param [App] app App object running the application.
    # @param [Integer] x the column to modify
    # @param [Integer] y1 the beginning coordinates
    # @param [Integer] y2 the ending coordinates
    # @param [Char] colour the colour to apply on the column.
    def initialize(app, x, y1, y2, colour)
      super(app)
      @x = x.to_i
      @y1 = y1.to_i
      @y2 = y2.to_i
      @colour = colour
    end

    # Execute the command.
    # Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
    def execute
      fail MissingBitmap if app.bitmap.nil?
      @saved_data = ""
      (y1..y2).each do |y|
        @saved_data << app.bitmap[x, y]
        app.bitmap[x, y] = colour
      end
    end

    # Undo the command.
    def undo
      (y1..y2).each_with_index do |y, i|
        app.bitmap[x, y] = saved_data[i]
      end
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [VerticalDraw] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 4) if args.length != 4
      fail InvalidArguments unless args[0].is_i? && args[1].is_i? && args[2].is_i? && args[3].is_colour?
      new(app, *args)
    end
  end
end