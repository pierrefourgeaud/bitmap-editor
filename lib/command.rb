class Command
  attr_reader :app

  def initialize(app)
    @app = app
  end

  def execute
    fail NotImplementedMethod
  end
end