class Command
  attr_reader :app

  # Initialize Command Class.
  def initialize(app)
    @app = app
  end

  # Method that should be implemented by the child class.
  def execute
    fail NotImplementedMethod
  end
end