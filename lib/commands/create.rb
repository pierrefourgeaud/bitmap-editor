require './lib/utils'
require './lib/bitmap'
require './lib/undoable_command'

module Commands
  class Create < ::UndoableCommand
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
      @saved_data = app.bitmap unless app.bitmap.nil?
      app.bitmap = Bitmap.new(@width, @height)
    end

    # Undo the command.
    def undo
      app.bitmap = saved_data
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Create] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 2) if args.length != 2
      fail InvalidArguments unless Utils.is_i?(args[0]) && Utils.is_i?(args[1])
      new(app, *args)
    end
  end
end