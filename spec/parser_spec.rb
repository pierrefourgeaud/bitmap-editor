require 'app'
require 'parser'

describe Parser do

  let(:app)  { App.new }

  subject { Parser.new(app) }

  describe ".initialize" do

    it { expect(subject.app).to eq(app) }

  end

  describe "#parse" do

    context "when the command is valid" do

      it { expect(subject.parse("I 5 6")).to   be_a(Commands::Create) }
      it { expect(subject.parse("X")).to       be_a(Commands::Quit) }
      it { expect(subject.parse("L 2 3 A")).to be_a(Commands::SetPixel) }
      it { expect(subject.parse("S")).to       be_a(Commands::Show) }

    end

    context "when the command is invalid" do

      it { expect { subject.parse("FOO") }.to raise_error(InvalidCommand) }

    end

  end

end