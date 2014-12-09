require './lib/parser'
require './lib/command_manager'

class App
  attr_accessor :bitmap
  attr_reader   :parser, :cmd_mgr

  # Initialize App Class.
  def initialize
    @bitmap = nil
    @parser = Parser.new(self)
    @cmd_mgr = CommandManager.new
  end

  # Run the application. Display the prompt and wait for an input.
  # The application will run until the Quit command is called.
  def run
    catch(:quit) do
      while line = readline
        begin
          cmd = @parser.parse(line)
          cmd.execute
          cmd_mgr.add_command(cmd) if cmd.is_a?(UndoableCommand)
        rescue BitmapEditorError => e
          puts e.message
        end
      end
    end

  end

  def quit
  end

  # Display the prompt and wait for an input from the user.
  #
  # @return [String] The line the user wrote.
  def readline
    print "> "
    $stdin.gets
  end

end