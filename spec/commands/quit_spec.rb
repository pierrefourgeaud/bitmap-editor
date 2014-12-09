require 'commands/quit'
require 'app'

describe Commands::Quit do

  let(:app)    { App.new }

  subject { Commands::Quit.new(app) }

  describe ".initialize" do

    it { expect(subject.app).to eq(app) }

  end

  describe "#execute" do

    it { expect { subject.execute }.to throw_symbol(:quit) }

  end

  describe ".create" do

    context "when correct arguments" do

      subject { Commands::Quit.create(app) }

      it { expect(subject).to be_a(Commands::Quit) }

    end

    context "when bad number of arguments" do

      it { expect { Commands::Quit.create(app, "foo") }.to raise_error(BadNumberArguments) }

    end

  end

end