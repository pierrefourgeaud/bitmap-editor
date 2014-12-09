require './lib/command'

module Commands
  class Redo < ::Command
    # Execute the command. Redo the previous command.
    def execute
      app.cmd_mgr.redo_cmd
    end

    # Class method. Verify the arguments and create the command.
    #
    # @param [App] app App object running the application.
    # @param [] args List of the arguments passed to the initialize method.
    # @return [Redo] the newly created instance of the command.
    def self.create(app, *args)
      fail BadNumberArguments.new(args.length, 0) unless args.empty?
      new(app)
    end
  end
end