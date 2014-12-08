require 'bitmap'

describe Bitmap do

  let(:width)  { 2 }
  let(:height) { 2 }

  subject { Bitmap.new(width, height) }

  describe ".initialize" do

    it { expect(subject.width).to eq(width) }
    it { expect(subject.height).to eq(height) }
    it { expect(subject.data).to eq("O" * width * height) }

  end

  describe "#clear" do

    before do
      subject[1, 1] = 'A'
    end

    it { expect { subject.clear }.to change { subject.data }.from('AOOO').to('OOOO') }

  end

  describe "#[]=" do

    context "when coordinates are valid" do

      it { expect { subject[1, 1] = "A" }.to change { subject.data }.from('OOOO').to('AOOO') }

    end

    context "when coordinates are invalid" do

      it { expect { subject[0, 1] = "A" }.to raise_error(OutOfRange) }

    end

  end

  describe "#[]" do

    context "when coordinates are valid" do

      before do
        subject[1, 2] = 'A'
      end

      it { expect(subject[1, 2]).to eq('A') }

    end

    context "when coordinates are invalid" do

      it { expect { subject[0, 1] }.to raise_error(OutOfRange) }

    end

  end

  describe "#check_range" do

    context "when the provided coordinates are correct" do

      it { expect(subject.check_range(1, 1)).to eq(true) }

    end

    context "when the provided coordinates are incorrect" do

      it { expect(subject.check_range(0, 1)).to eq(false) }
      it { expect(subject.check_range(1, 0)).to eq(false) }
      it { expect(subject.check_range(3, 1)).to eq(false) }
      it { expect(subject.check_range(1, 3)).to eq(false) }

    end

  end

end