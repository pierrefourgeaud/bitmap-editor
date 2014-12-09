class CommandManager
  attr_reader :undo_cmds, :redo_cmds

  def initialize
    @undo_cmds = []
    @redo_cmds = []
  end

  def add_command(cmd)
    undo_cmds.push(cmd)
    undo_cmds.shift if undo_cmds.size > CommandManager.max_commands
  end

  def undo_cmd
    fail NoStackedCommand, "No command to Undo." if undo_cmds.empty?
    cmd = undo_cmds.pop
    cmd.undo
    redo_cmds.push(cmd)
  end

  def redo_cmd
    fail NoStackedCommand, "No command to Redo." if redo_cmds.empty?
    cmd = redo_cmds.pop
    cmd.execute
    add_command(cmd)
  end

  def self.max_commands
    10
  end
end