require 'command_manager'

describe CommandManager do

  let(:app) { App.new }

  subject { CommandManager.new }

  describe "#add_command" do

    context "when the number of commands is less that max_commands" do

      let(:undoable_cmd) { Commands::Clear.new(app) }
      let(:cmd)          { Commands::Show.new(app) }

      it { expect { subject.add_command(undoable_cmd) }.to change { subject.undo_cmds.size }.by(1) }
      it { expect { subject.add_command(cmd) }.to change { subject.undo_cmds.size }.by(0) }

    end

    context "when the number of commands is more than max_commands" do

      let(:cmd1) { Commands::Clear.new(app) }
      let(:cmd2) { Commands::Clear.new(app) }

      before do
        allow(CommandManager).to receive(:max_commands).and_return(1)
        subject.add_command(cmd1)
      end

      it { expect { subject.add_command(cmd2) }.to change { subject.undo_cmds.size }.by(0) }
      it { expect { subject.add_command(cmd2) }.to change { subject.undo_cmds[0] }.to(cmd2) }

    end

  end

  describe "#undo_cmd" do

    context "where there is no command to undo" do

      it { expect { subject.undo_cmd }.to raise_error(NoStackedCommand) }

    end

    context "when there is at least one command to undo" do

      let(:cmd) { Commands::Create.new(app, 2, 2) }

      before do
        cmd.execute
        subject.add_command(cmd)
      end

      it { expect { subject.undo_cmd }.to change { app.bitmap }.to(nil) }
      it { expect { subject.undo_cmd }.to change { subject.undo_cmds.size }.by(-1) }
      it { expect { subject.undo_cmd }.to change { subject.redo_cmds.size }.by(1) }

    end

  end

  describe "#redo_cmd" do

    context "where there is no command to redo" do

      it { expect { subject.redo_cmd }.to raise_error(NoStackedCommand) }

    end

    context "when there is at least one command to redo" do

      let(:cmd) { Commands::Create.new(app, 2, 2) }

      before do
        cmd.execute
        subject.add_command(cmd)
        subject.undo_cmd
      end

      it { expect { subject.redo_cmd }.to change { app.bitmap }.to kind_of(Bitmap) }
      it { expect { subject.redo_cmd }.to change { subject.undo_cmds.size }.by(1) }
      it { expect { subject.redo_cmd }.to change { subject.redo_cmds.size }.by(-1) }

    end

  end

  describe "#commands_threshold_reached?" do

    let(:cmd) { Commands::Create.new(app, 2, 2) }

    before do
      allow(CommandManager).to receive(:max_commands).and_return(1)
      allow(subject).to receive(:undo_cmds).and_return([])
      subject.undo_cmds.push(cmd)
    end

    context "when the number of commands is under the threshold" do

      it { expect(subject.commands_threshold_reached?).to eq(false) }

    end

    context "when the number of commands is under the threshold" do

      before do
        subject.undo_cmds.push(cmd)
      end

      it { expect(subject.commands_threshold_reached?).to eq(true) }

    end

  end
end