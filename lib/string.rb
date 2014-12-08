class String
  def is_i?
    /\A[-+]?\d+\z/ === self
  end

  def is_colour?
    size == 1 && self[0] >= 'A' && self[0] <= 'Z'
  end
end