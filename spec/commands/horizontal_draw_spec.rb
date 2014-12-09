require 'commands/horizontal_draw'
require 'app'

describe Commands::HorizontalDraw do

  let(:x1) { "2" }
  let(:x2) { "3" }
  let(:y)  { "2" }
  let(:colour) { "Z" }
  let(:app)    { App.new }

  context "when a bitmap is already created" do

    before do
      Commands::Create.new(app, 3, 2).execute
    end

    subject { Commands::HorizontalDraw.new(app, x1, x2, y, colour) }

    describe ".initialize" do

      it { expect(subject.x1).to eq(x1.to_i) }
      it { expect(subject.x2).to eq(x2.to_i) }
      it { expect(subject.y).to  eq(y.to_i) }
      it { expect(subject.colour).to eq(colour) }
      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      before do
        subject.execute
      end

      it { expect(app.bitmap[x1.to_i, y.to_i]).to eq(colour) }
      it { expect(app.bitmap[x2.to_i, y.to_i]).to eq(colour) }

    end

    describe "#undo" do

      before do
        subject.execute
      end

      it { expect{ subject.undo }.to change { app.bitmap.data }.from('OOOOZZ').to('OOOOOO') }

    end

    describe ".create" do

      context "when correct arguments" do

        subject { Commands::HorizontalDraw.create(app, x1, x2, y, colour) }

        it { expect(subject).to be_a(Commands::HorizontalDraw) }
        it { expect(subject.x1).to eq(x1.to_i) }
        it { expect(subject.x2).to eq(x2.to_i) }
        it { expect(subject.y).to eq(y.to_i) }
        it { expect(subject.colour).to eq(colour) }

      end

      context "when bad number of arguments" do

        it { expect { Commands::HorizontalDraw.create(app, x1) }.to raise_error(BadNumberArguments) }

      end

      context "when bad type of arguments" do

        it { expect { Commands::HorizontalDraw.create(app, "foo", x2, y, colour) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::HorizontalDraw.create(app, x1, "foo", y, colour) }.to  raise_error(InvalidArguments) }
        it { expect { Commands::HorizontalDraw.create(app, x1, x2, "foo", colour) }.to raise_error(InvalidArguments) }
        it { expect { Commands::HorizontalDraw.create(app, x1, x2, y, "foo") }.to      raise_error(InvalidArguments) }

      end

    end

  end

  context "when no bitmap created" do

    subject { Commands::HorizontalDraw.new(app, x1, x2, y, colour) }

    describe ".initialize" do

      it { expect(subject.x1).to eq(x1.to_i) }
      it { expect(subject.x2).to eq(x2.to_i) }
      it { expect(subject.y).to  eq(y.to_i) }
      it { expect(subject.colour).to eq(colour) }
      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      it { expect{ subject.execute }.to raise_error(MissingBitmap) }

    end

  end

end