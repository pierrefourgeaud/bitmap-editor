class Command
  def initialize(app)
    @app = app
  end

  def execute
    fail NotImplementedMethod
  end
end