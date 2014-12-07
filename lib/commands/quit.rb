module Commands
  class Quit < ::Command
    # Initialize Quit Class.
    #
    # @param [App] app App object running the application.
    def initialize(app)
      super(app)
    end

    # Execute the command. Set a flag to quit the application.
    def execute
      @app.running = false
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Quit] the newly created instance of the command.
    def self.create(app, *args)
      Quit.new(app)
    end
  end
end