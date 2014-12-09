require './lib/undoable_command'

module Commands
  class Clear < ::UndoableCommand
    # Execute the command. Clear the bitmap.
    def execute
      fail MissingBitmap if app.bitmap.nil?
      @saved_data = app.bitmap.data
      app.bitmap.clear
    end

    # Undo the command.
    def undo
      app.bitmap.data = saved_data
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Clear] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 0) unless args.empty?
      new(app)
    end
  end
end