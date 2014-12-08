require './lib/parser'

class App
  attr_accessor :bitmap
  attr_reader   :parser

  # Initialize App Class.
  def initialize
    @bitmap = nil
    @parser = Parser.new(self)
  end

  # Run the application. Display the prompt and wait for an input.
  # The application will run until the Quit command is called.
  def run
    catch(:quit) do
      while line = readline
        begin
          @parser.parse(line).execute
        rescue StandardError => e
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