require 'command'
require 'commands/undo'
require 'app'

describe Commands::Undo do

  let(:app)    { App.new }

  subject { Commands::Undo.new(app) }

  describe ".initialize" do

    it { expect(subject.app).to eq(app) }

  end

  describe "#execute" do

    let(:cmd) { Commands::Create.new(app, 2, 2) }

    before do
      cmd.execute
      app.cmd_mgr.add_command(cmd)
    end

    it { expect { subject.execute }.to change { app.bitmap }.to(nil) }

  end

  describe ".create" do

    context "when correct arguments" do

      subject { Commands::Undo.create(app) }

      it { expect(subject).to be_a(Commands::Undo) }

    end

    context "when bad number of arguments" do

      it { expect { Commands::Undo.create(app, "foo") }.to raise_error(BadNumberArguments) }

    end

  end

end