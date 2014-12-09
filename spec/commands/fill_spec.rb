require 'command'
require 'commands/fill'
require 'app'

describe Commands::Fill do

  let(:x) { "1" }
  let(:y)  { "1" }
  let(:colour) { "J" }
  let(:app)    { App.new }

  context "when a bitmap is already created" do

    before do
      Commands::Create.new(app, 2, 2).execute
    end

    subject { Commands::Fill.new(app, x, y, colour) }

    describe ".initialize" do

      it { expect(subject.x).to eq(x.to_i) }
      it { expect(subject.y).to eq(y.to_i) }
      it { expect(subject.colour).to eq(colour) }
      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      before do
        app.bitmap[1, 2] = 'A'
      end

      it { expect{ subject.execute }.to change { app.bitmap.data }.from('OOAO').to('JJAJ') }

    end

    describe "#undo" do

      before do
        subject.execute
      end

      it { expect{ subject.undo }.to change { app.bitmap.data }.from('JJJJ').to('OOOO') }

    end

    describe ".create" do

      context "when correct arguments" do

        subject { Commands::Fill.create(app, x, y, colour) }

        it { expect(subject).to be_a(Commands::Fill) }
        it { expect(subject.x).to eq(x.to_i) }
        it { expect(subject.y).to eq(y.to_i) }
        it { expect(subject.colour).to eq(colour) }

      end

      context "when bad number of arguments" do

        it { expect { Commands::Fill.create(app, x) }.to raise_error(BadNumberArguments) }

      end

      context "when bad type of arguments" do

        it { expect { Commands::Fill.create(app, "foo", y, colour) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::Fill.create(app, x, "foo", colour) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::Fill.create(app, x, y, "foo") }.to raise_error(InvalidArguments) }

      end

    end

  end

  context "when no bitmap created" do

    subject { Commands::Fill.new(app, x, y, colour) }

    describe ".initialize" do

      it { expect(subject.x).to eq(x.to_i) }
      it { expect(subject.y).to eq(y.to_i) }
      it { expect(subject.colour).to eq(colour) }
      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      it { expect{ subject.execute }.to raise_error(MissingBitmap) }

    end

  end

end