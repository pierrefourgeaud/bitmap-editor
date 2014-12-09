require 'command'
require 'commands/create'
require 'app'

describe Commands::Create do

  let(:width)  { "2" }
  let(:height) { "2" }
  let(:app)    { App.new }

  subject { Commands::Create.new(app, width, height) }

  describe ".initialize" do

    it { expect(subject.width).to eq(width.to_i) }
    it { expect(subject.height).to eq(height.to_i) }
    it { expect(subject.app).to eq(app) }

  end

  describe "#execute" do

    before do
      subject.execute
    end

    it { expect(app.bitmap).to be_a(Bitmap) }
    it { expect(app.bitmap.width).to eq(width.to_i) }
    it { expect(app.bitmap.height).to eq(height.to_i) }

  end

  describe "#undo" do

    context "when app didn't have a bitmap before" do

      before do
        subject.execute
      end

      it { expect{ subject.undo }.to change { app.bitmap }.to(nil) }

    end

    context "when app have a bitmap before" do

      let(:bm) { Bitmap.new(width.to_i, height.to_i) }

      before do
        app.bitmap = bm
        subject.execute
      end

      it { expect{ subject.undo }.to change { app.bitmap }.to(bm) }

    end

  end

  describe ".create" do

    context "when correct arguments" do

      subject { Commands::Create.create(app, width, height) }

      it { expect(subject).to be_a(Commands::Create) }
      it { expect(subject.width).to eq(width.to_i) }
      it { expect(subject.height).to eq(height.to_i) }

    end

    context "when bad number of arguments" do

      it { expect { Commands::Create.create(app, width) }.to raise_error(BadNumberArguments) }

    end

    context "when bad type of arguments" do

      it { expect { Commands::Create.create(app, width, "foo") }.to raise_error(InvalidArguments) }
      it { expect { Commands::Create.create(app, "foo", height) }.to raise_error(InvalidArguments) }

    end

  end

end