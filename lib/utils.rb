module Utils
  def self.is_i?(str)
    /\A[-+]?\d+\z/ === str
  end

  def self.is_colour?(str)
    str.size == 1 && str[0] >= 'A' && str[0] <= 'Z'
  end
end