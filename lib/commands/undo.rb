module Commands
  class Undo < ::Command
    # Execute the command. Undo the previous command.
    def execute
      app.cmd_mgr.undo_cmd
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Undo] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 0) unless args.empty?
      new(app)
    end
  end
end