class CommandManager
  attr_reader :undo_cmds, :redo_cmds

  # Initialize the CommandManager.
  def initialize
    @undo_cmds = []
    @redo_cmds = []
  end

  # Add an undoable command to the undo stack.
  #
  # @param [UndoableCommand] cmd the undoable command to add.
  def add_command(cmd)
    return unless cmd.can_be_undone?
    undo_cmds.push(cmd)
    undo_cmds.shift if commands_threshold_reached?
  end

  # Undo function. Execute the undo function of the last cmd pushed on the stack.
  # It unstack the commands and push it on the redo stack.
  # Raise an exception if there is no command to undo.
  def undo_cmd
    fail NoStackedCommand, "No command to Undo." if undo_cmds.empty?
    cmd = undo_cmds.pop
    cmd.undo
    redo_cmds.push(cmd)
  end

  # Redo function. Execute the execute function of the last cmd pushed on the stack.
  # It unstack the commands.
  # Raise an exception if there is no command to redo.
  def redo_cmd
    fail NoStackedCommand, "No command to Redo." if redo_cmds.empty?
    cmd = redo_cmds.pop
    cmd.execute
    add_command(cmd)
  end

  # Return true if the number of commands on the undo stack is more than
  # the number allowed.
  def commands_threshold_reached?
    undo_cmds.size > CommandManager.max_commands
  end

  # The number of commands allowed on the stack
  def self.max_commands
    10
  end
end