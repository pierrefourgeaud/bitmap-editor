require 'commands/redo'
require 'app'

describe Commands::Redo do

  let(:app)    { App.new }

  subject { Commands::Redo.new(app) }

  describe ".initialize" do

    it { expect(subject.app).to eq(app) }

  end

  describe "#execute" do

    let(:cmd) { Commands::Create.new(app, 2, 2) }
    let(:undo){ Commands::Undo.new(app) }

    before do
      cmd.execute
      app.cmd_mgr.add_command(cmd)
      undo.execute
    end

    it { expect { subject.execute }.to change { app.bitmap }.from(nil).to kind_of(Bitmap) }

  end

  describe ".create" do

    context "when correct arguments" do

      subject { Commands::Redo.create(app) }

      it { expect(subject).to be_a(Commands::Redo) }

    end

    context "when bad number of arguments" do

      it { expect { Commands::Redo.create(app, "foo") }.to raise_error(BadNumberArguments) }

    end

  end

end