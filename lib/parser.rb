class Parser
  attr_reader :app

  commands.each do |c, v|
    define_method("command_#{c}") do |*args|
      Commands.const_get("#{v}").create(@app, *args)
    end
  end

  def initialize(app)
    @app = app
  end

  def parse(str)
    args = str.split
    command = args.shift
    public_send("command_#{command}", *args)
  end

  def self.commands
    {
      "I" => "Create",
      "S" => "Show",
      "X" => "Quit",
      "L" => "SetPixel"
    }
  end
end