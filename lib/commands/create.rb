module Commands
  class Create < ::Command
    # Initialize Create Class.
    #
    # @param [App] app App object running the application.
    # @param [Integer] width the width of the bitmap
    # @param [Integer] height the height of the bitmap
    def initialize(app, width, height)
      super(app)
      @width  = width
      @height = height
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
      Create.new(app, *args)
    end
  end
end