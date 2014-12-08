class Error < StandardError; end

class OutOfRange < Error
end

class BadNumberArguments < Error
end

class InvalidArguments < Error
  def initialize(msg = 'The command does not have the correct arguments.')
    super
  end
end

class InvalidCommand < Error
  def initialize(cmd)
    super("The command '#{cmd}' does not exist.")
  end
end