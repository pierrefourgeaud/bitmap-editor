class App
  attr_accessor :bitmap, :running

  def initialize()
    @bitmap = nil
    @running = true
    @parser = Parser.new(self)
  end

  def run()
    while @running
      @command = @parser.parse(readline)
      @command.execute if @command
    end
  end

  def readline
    print "> "
    $stdin.gets
  end

end