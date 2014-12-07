require 'matrix'

class Bitmap
  attr_accessor :width, :height

  def initialize(width, height)
    @width = width.to_i
    @height = height.to_i
    @data = nil
  end

  def data_size
    width * height
  end

  def data
    @data ||= "O" * data_size
  end

  def clear
    return nil unless @data
    @data = "O" * data_size
  end

  def []=(x, y, c)
    data[y * width + x] = c
  end

  def [](x, y)
    data[y * width + x]
  end
end