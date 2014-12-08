require './lib/string'
require './lib/bitmap'

module Commands
  class Create < ::Command
    attr_reader :width, :height

    # Initialize Create Class.
    #
    # @param [App] app App object running the application.
    # @param [Integer] width the width of the bitmap
    # @param [Integer] height the height of the bitmap
    def initialize(app, width, height)
      super(app)
      @width  = width.to_i
      @height = height.to_i
    end

    # Execute the command. Create the Bitmap object.
    def execute
      @app.bitmap = Bitmap.new(@width, @height)
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Create] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 2) if args.length != 2
      fail InvalidArguments unless args[0].is_i? && args[1].is_i?
      new(app, *args)
    end
  end
end