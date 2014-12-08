class BitmapEditorError < StandardError; end

class MissingBitmap < BitmapEditorError
  def initialize(msg = 'No bitmap created, create a bitmap before trying to modify it.')
    super
  end
end

class OutOfRange < BitmapEditorError
  def initialize(msg = 'The pixel you are trying to reach is out of range.')
    super
  end
end

class BadNumberArguments < BitmapEditorError
  def initialize(given, expected)
    super("Wrong number of arguments (#{given} given, #{expected} expected).")
  end
end

class InvalidArguments < BitmapEditorError
  def initialize(msg = 'The command does not have the correct arguments.')
    super
  end
end

class InvalidCommand < BitmapEditorError
  def initialize(cmd)
    super("The command '#{cmd}' does not exist.")
  end
end