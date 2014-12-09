require './lib/command'

class UndoableCommand < Command
  def undo
    fail NotImplementedMethod
  end

  # Boolean method that return true is the method can be undone
  def can_be_undone?
    true
  end
end