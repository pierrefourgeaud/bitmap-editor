class App
  attr_accessor :bitmap, :running

  # Initialize App Class.
  def initialize
    @bitmap = nil
    @running = true
    @parser = Parser.new(self)
  end

  # Run the application. Display the prompt and wait for an input.
  # The application will run until the Quit command is called.
  def run
    while @running
      @command = @parser.parse(readline)
      @command.execute if @command
    end
  end

  # Display the prompt and wait for an input from the user.
  #
  # @return [String] The line the user wrote.
  def readline
    print "> "
    $stdin.gets
  end

end