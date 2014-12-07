module Commands
  class Show < ::Command
    def initialize(app)
      super(app)
    end

    def execute()
      width = @app.bitmap.width
      height = @app.bitmap.height
      (0...height).each do |y|
        (0...width).each do |x|
          print @app.bitmap.get(x, y)
        end
        puts
      end
    end

    # Spec <command>
    def self.create(app, *args)
      Show.new(app)
    end
  end
end