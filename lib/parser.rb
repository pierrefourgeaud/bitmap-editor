require './lib/command'
require './lib/commands/create'
require './lib/commands/quit'
require './lib/commands/set_pixel'
require './lib/commands/show'
require './lib/commands/vertical_draw'
require './lib/commands/horizontal_draw'
require './lib/commands/fill'
require './lib/bitmap_editor_error'

class Parser
  attr_reader :app

  def self.commands
    {
      "I" => "Create",
      "S" => "Show",
      "X" => "Quit",
      "L" => "SetPixel",
      "V" => "VerticalDraw",
      "H" => "HorizontalDraw",
      "F" => "Fill"
    }
  end

  Parser.commands.each do |c, v|
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
    fail InvalidCommand, command unless Parser.commands.has_key?(command)
    public_send("command_#{command}", *args)
  end
end