require 'command'
require 'commands/set_pixel'
require 'app'

describe Commands::SetPixel do

  let(:x) { "1" }
  let(:y) { "2" }
  let(:colour) { "A" }
  let(:app)    { App.new }

  before do
    Commands::Create.new(app, 2, 2).execute
  end

  subject { Commands::SetPixel.new(app, x, y, colour) }

  describe ".initialize" do

    it { expect(subject.x).to eq(x.to_i) }
    it { expect(subject.y).to eq(y.to_i) }
    it { expect(subject.colour).to eq(colour) }
    it { expect(subject.app).to eq(app) }

  end

  describe "#execute" do

    before do
      subject.execute
    end

    it { expect(app.bitmap[x.to_i, y.to_i]).to eq(colour) }

  end

  describe ".create" do

    context "when correct arguments" do

      subject { Commands::SetPixel.create(app, x, y, colour) }

      it { expect(subject).to be_a(Commands::SetPixel) }
      it { expect(subject.x).to eq(x.to_i) }
      it { expect(subject.y).to eq(y.to_i) }
      it { expect(subject.colour).to eq(colour) }

    end

    context "when bad number of arguments" do

      it { expect { Commands::SetPixel.create(app, x) }.to raise_error(InvalidArguments) }

    end

    context "when bad type of arguments" do

      it { expect { Commands::SetPixel.create(app, x, "foo", colour) }.to raise_error(InvalidArguments) }
      it { expect { Commands::SetPixel.create(app, "foo", y, colour) }.to raise_error(InvalidArguments) }
      it { expect { Commands::SetPixel.create(app, x, y, "foo") }.to      raise_error(InvalidArguments) }

    end

  end

end