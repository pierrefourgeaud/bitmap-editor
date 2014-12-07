module Commands
  class Quit < ::Command
    def initialize(app)
      super(app)
    end

    def execute()
      @app.running = false
    end

    # Spec <command>
    def self.create(app, *args)
      Quit.new(app)
    end
  end
end