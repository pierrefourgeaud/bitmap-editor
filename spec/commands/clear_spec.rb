require 'commands/clear'
require 'app'

describe Commands::Clear do

  let(:app)    { App.new }

  context "when a bitmap is already created" do

    before do
      Commands::Create.new(app, 2, 2).execute
    end

    subject { Commands::Clear.new(app) }

    describe ".initialize" do

      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      before do
        app.bitmap[1, 1] = 'A'
      end

      it { expect{ subject.execute }.to change { app.bitmap.data }.from('AOOO').to('OOOO') }

    end

    describe "#undo" do

      before do
        app.bitmap[1, 1] = 'A'
        subject.execute
      end

      it { expect{ subject.undo }.to change { app.bitmap.data }.from('OOOO').to('AOOO') }

    end

    describe ".create" do

      context "when correct arguments" do

        subject { Commands::Clear.create(app) }

        it { expect(subject).to be_a(Commands::Clear) }

      end

      context "when bad number of arguments" do

        it { expect { Commands::Clear.create(app, "foo") }.to raise_error(BadNumberArguments) }

      end

    end

  end

  context "when no bitmap created" do

    subject { Commands::Clear.new(app) }

    describe ".initialize" do

      it { expect(subject.app).to eq(app) }

    end

    describe "#execute" do

      it { expect{ subject.execute }.to raise_error(MissingBitmap) }

    end

  end

end