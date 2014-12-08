module Commands
  class Clear < ::Command
    # Execute the command. Clear the bitmap.
    def execute
      fail MissingBitmap if app.bitmap.nil?
      app.bitmap.clear
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