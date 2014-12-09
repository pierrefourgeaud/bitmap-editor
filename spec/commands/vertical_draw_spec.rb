require 'commands/vertical_draw'
require 'app'

describe Commands::VerticalDraw do

  let(:x)  { "2" }
  let(:y1) { "1" }
  let(:y2) { "3" }
  let(:colour) { "W" }
  let(:app)    { App.new }

  context "when a bitmap is already created" do

    before do
      Commands::Create.new(app, 2, 3).execute
    end

    subject { Commands::VerticalDraw.new(app, x, y1, y2, colour) }

    describe ".initialize" do

      it { expect(subject.x).to eq(x.to_i) }
      it { expect(subject.y1).to eq(y1.to_i) }
      it { expect(subject.y2).to eq(y2.to_i) }
      it { expect(subject.colour).to eq(colour) }
      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      before do
        subject.execute
      end

      it { expect(app.bitmap[x.to_i, y1.to_i]).to eq(colour) }
      it { expect(app.bitmap[x.to_i, y2.to_i]).to eq(colour) }

    end

    describe "#undo" do

      before do
        subject.execute
      end

      it { expect{ subject.undo }.to change { app.bitmap.data }.from('OWOWOW').to('OOOOOO') }

    end

    describe ".create" do

      context "when correct arguments" do

        subject { Commands::VerticalDraw.create(app, x, y1, y2, colour) }

        it { expect(subject).to be_a(Commands::VerticalDraw) }
        it { expect(subject.x).to eq(x.to_i) }
        it { expect(subject.y1).to eq(y1.to_i) }
        it { expect(subject.y2).to eq(y2.to_i) }
        it { expect(subject.colour).to eq(colour) }

      end

      context "when bad number of arguments" do

        it { expect { Commands::VerticalDraw.create(app, x) }.to raise_error(BadNumberArguments) }

      end

      context "when bad type of arguments" do

        it { expect { Commands::VerticalDraw.create(app, "foo", y1, y2, colour) }.to raise_error(InvalidArguments) }
        it { expect { Commands::VerticalDraw.create(app, x, "foo", y2, colour) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::VerticalDraw.create(app, x, y1, "foo", colour) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::VerticalDraw.create(app, x, y1, y2, "foo") }.to      raise_error(InvalidArguments) }

      end

    end

  end

  context "when no bitmap created" do

    subject { Commands::VerticalDraw.new(app, x, y1, y2, colour) }

    describe ".initialize" do

      it { expect(subject.x).to eq(x.to_i) }
      it { expect(subject.y1).to eq(y1.to_i) }
      it { expect(subject.y2).to eq(y2.to_i) }
      it { expect(subject.colour).to eq(colour) }
      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      it { expect{ subject.execute }.to raise_error(MissingBitmap) }

    end

  end

end