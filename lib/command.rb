class Command
  attr_accessor :saved_data
  attr_reader   :app

  # Initialize Command Class.
  def initialize(app)
    @app = app
    @saved_data = nil
  end

  # Method that should be implemented by the child class.
  def execute
    fail NotImplementedMethod
  end

  # Method that should be implemented by the undoable command.
  # Otherwise it will do nothing.
  def undo
    puts "nothin"
  end
end

class UndoableCommand < Command
  def undo
    fail NotImplementedMethod
  end
end