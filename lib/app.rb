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

  # Run the application. Call parse_line.
  # The application will run until the Quit command is called.
  def run
    catch(:quit) do
      while line = readline
        parse_line(line)
      end
    end

  end

  # Display the prompt and wait for an input.
  def parse_line(line)
    cmd = @parser.parse(line)
    cmd.execute
    cmd_mgr.add_command(cmd) if cmd.can_be_undone?
  rescue BitmapEditorError => e
    puts e.message
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