require 'command'
require 'commands/show'
require 'app'

describe Commands::Show do

  let(:app)    { App.new }

  subject { Commands::Show.new(app) }

  describe ".initialize" do

    it { expect(subject.app).to eq(app) }

  end

  describe "#execute" do

    

  end

  describe ".create" do

    context "when correct arguments" do

      subject { Commands::Show.create(app) }

      it { expect(subject).to be_a(Commands::Show) }

    end

    context "when bad number of arguments" do

      it { expect { Commands::Show.create(app, "foo") }.to raise_error(InvalidArguments) }

    end

  end

end