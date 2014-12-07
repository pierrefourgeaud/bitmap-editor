module Commands
  class Create < ::Command
    def initialize(app, width, height)
      super(app)
      @width  = width
      @height = height
    end

    def execute()
      @app.bitmap = Bitmap.new(@width, @height)
    end

    # Spec <command> <width> <height>
    def self.create(app, *args)
      Create.new(app, *args)
    end
  end
end