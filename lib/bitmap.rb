class Bitmap
  attr_reader :width, :height

  # Initialize Bitmap Class.
  #
  # @param [Integer] width the width of the bitmap
  # @param [Integer] height the height of the bitmap
  def initialize(width, height)
    @width = width.to_i
    @height = height.to_i
    clear
  end

  # Return the size of the underlying data for the bitmap.
  #
  # @return [Integer] the size of the data representing the bitmap.
  def size
    width * height
  end

  # Return the data and set it if it is not done yet.
  #
  # @param [String] the data representing the bitmap.
  def data
    @data ||= "O" * size
  end

  # Clear the bitmap by setting all the pixel to O.
  #
  # @return [String] the data representing the bitmap all with O.
  def clear
    @data = "O" * size
  end

  # Element reference operator to set a pixel with the given color.
  #
  # @param [Integer] x the x of the pixel
  # @param [Integer] y the y of the pixel
  # @param [Char] the new color of the pixel
  def []=(x, y, c)
    check_range(x, y)
    data[(y-1) * width + (x-1)] = c
  end

  # Element reference operator to get a pixel.
  #
  # @param [Integer] x the x of the pixel
  # @param [Integer] y the y of the pixel
  # @return [Char] the color of the pixel
  def [](x, y)
    check_range(x, y)
    data[(y-1) * width + (x-1)]
  end

  private

  def check_range(x, y)
    fail OutOfRange if x < 1 || y < 1 || x > width || y > height
  end
end