module Commands
  class Show < ::Command
    # Execute the command. Display the bitmap.
    def execute
      width = @app.bitmap.width
      height = @app.bitmap.height
      (0...height).each do |y|
        (0...width).each do |x|
          print @app.bitmap.get(x, y)
        end
        puts
      end
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Show] the newly created instance of the command.
    def self.create(app, *args)
      new(app)
    end
  end
end